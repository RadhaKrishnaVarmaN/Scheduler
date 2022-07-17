CREATE PROCEDURE dbo.usp_schedule_generate
(
	@schedule_id	INT = NULL
)
AS
BEGIN
	-- Note: Language = us_english; DateFirst = 7 (Sunday);

	DECLARE @today_date AS DATE = CAST(GETDATE() AS DATE)
	DECLARE @today_weekday INT = DATEPART(DW, @today_date)
	DECLARE @today_weekday_name VARCHAR(12) = '$.' + LOWER(DATENAME(WEEKDAY,  @today_date))
	DECLARE @this_day INT = DATEPART(D, @today_date)
	DECLARE @this_day_name VARCHAR(10) = '$.day' + FORMAT(GETDATE(), 'dd')
	DECLARE @this_weekend_date DATE = DATEADD(DAY, CHOOSE(DATEPART(WEEKDAY, @today_date), 6, 5, 4, 3, 2, 1, 0), @today_date)
	DECLARE @this_month INT = MONTH(@today_date)
	DECLARE @this_month_name VARCHAR(12) = '$.' + LOWER(DATENAME(MONTH,  @today_date))
	DECLARE @this_monthend_date	DATE = EOMONTH(GETDATE())
	DECLARE @is_today_eomonth BIT = IIF(@this_monthend_date = @today_date, 1, 0)


	SELECT	s.schedule_id, s.schedule_name, st.time_value, st.time_minutes
	FROM	dbo.schedule s
	JOIN	dbo.schedule_time_enum st ON	st.time_minutes BETWEEN s.start_time_minutes AND s.repeat_end_time_minutes 
										AND st.time_minutes < 1440 
	WHERE	s.is_active = 1
		AND (@schedule_id IS NULL OR s.schedule_id = @schedule_id)
		AND @today_date BETWEEN s.[start_date] AND ISNULL(s.end_date, @today_date)
		AND (s.end_date IS NULL OR s.end_date <> @today_date OR st.time_minutes < s.end_time_minutes)
		-- Recurrence
		AND (	-- One-Time
				(s.schedule_type_id = 10 AND s.[start_date] = @today_date)
				-- Daily
			OR	(	s.schedule_type_id = 20 AND s.recur_interval > 0
				AND (	s.recur_interval = 1 
					OR	(DATEDIFF(D, s.start_date, @today_date) % s.recur_interval) = 0
					)
				)
				-- Weekly
			OR	(	s.schedule_type_id = 30 AND s.recur_interval > 0 
				AND (	s.recur_interval = 1 
					OR	(DATEDIFF(WK, s.start_date_weekstart_date, @this_weekend_date) % s.recur_interval) = 0
					)
				AND JSON_VALUE(weekdays_json, @today_weekday_name) = @today_weekday
				)
				-- Monthly-Days
			OR	(	s.schedule_type_id = 40 AND s.recur_interval > 0 
				AND (	s.recur_interval = 1 
					OR	(DATEDIFF(M, s.start_date_monthstart_date, @this_monthend_date) % s.recur_interval) = 0
					)
				AND JSON_VALUE(months_json, @this_month_name) = @this_month 
				AND (JSON_VALUE(days_json, @this_day_name) = @this_day OR (@is_today_eomonth = 1 AND JSON_VALUE(days_json, '$.last') = 32))
				)
			)
		-- Repeat
		AND (	-- One-Time
				(ISNULL(s.repeat_for_mins, 0) = 0 AND s.start_time_minutes = st.time_minutes)
				-- Every x minutes.
			OR	(s.repeat_for_mins > 0 AND ((st.time_minutes - s.start_time_minutes) % s.repeat_for_mins) = 0)
			)
END
GO
