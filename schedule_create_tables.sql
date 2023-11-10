
CREATE TABLE [dbo].[schedule_time_enum]
(
    [time_minutes]	INT	NOT NULL,
    [time_value]	TIME NOT NULL,
    CONSTRAINT	[pk_schedule_time_enum] PRIMARY KEY CLUSTERED ([time_minutes] ASC)
);
GO

-- A day has 1440 minutes. For 0 based index from 0 to 1439. Any value above 1439 will restart from zero.

DECLARE @time TIME = N'00:00:00'
;WITH st (time_minutes) AS
(
	SELECT time_minutes = 0
	UNION ALL
	SELECT time_minutes = st.time_minutes + 1 FROM st WHERE st.time_minutes < 1439
)
INSERT INTO [dbo].[schedule_time_enum]
SELECT  time_minutes
		, time_value = DATEADD(MI, time_minutes, @time)
FROM    st 
ORDER BY 1;
GO


GO
CREATE TABLE [dbo].[schedule_type]
(
    [schedule_type_id]		INT NOT NULL,
    [schedule_type_name]	VARCHAR (100) NOT NULL,
	[days_json]				VARCHAR (450)	NULL,
	[weeks_json]			VARCHAR (75)	NULL,
	[weekdays_json]			VARCHAR (125)	NULL,
	[months_json]			VARCHAR (200)	NULL,
    CONSTRAINT [pk_schedule_type] PRIMARY KEY CLUSTERED ([schedule_type_id] ASC),
    CONSTRAINT [uq_schedule_type_name] UNIQUE NONCLUSTERED ([schedule_type_name] ASC)
);
GO

INSERT INTO [dbo].[schedule_type] (schedule_type_id, schedule_type_name, days_json, weeks_json, weekdays_json, months_json)
VALUES (10, 'One Time', NULL, NULL, NULL, NULL)
	, (20, 'Daily', '{ "day01":1, "day02":2, "day03":3, "day04":4, "day05":5, "day06":6, "day07":7, "day08":8, "day09":9, "day10":10, "day11":11, "day12":12, "day13":13, "day14":14, "day15":15, "day16":16, "day17":17, "day18":18, "day19":19, "day20":20, "day21":21, "day22":22, "day23":23, "day24":24, "day25":25, "day26":26, "day27":27, "day28":28, "day29":29, "day30":30, "day31":31, "last":32}', NULL, NULL, NULL)
	, (30, 'Weekly', NULL, NULL, '{ "sunday":1, "monday":2, "tuesday":3, "wednesday":4, "thursday":5, "friday":6, "saturday":7 }', NULL)
	, (40, 'Monthly-Days', '{ "day01":1, "day02":2, "day03":3, "day04":4, "day05":5, "day06":6, "day07":7, "day08":8, "day09":9, "day10":10, "day11":11, "day12":12, "day13":13, "day14":14, "day15":15, "day16":16, "day17":17, "day18":18, "day19":19, "day20":20, "day21":21, "day22":22, "day23":23, "day24":24, "day25":25, "day26":26, "day27":27, "day28":28, "day29":29, "day30":30, "day31":31, "last":32}', NULL, NULL, '{ "january":1, "february":2, "march":3, "april":4, "may":5, "june":6, "july":7, "august":8, "september":9, "october":10, "november":11, "december":12 }')
--	, (41, 'Monthly-Weeks', NULL, '{ "first":1, "second":2, "third":3, "fourth":4, "last":5 }', '{ "sunday":1, "monday":2, "tuesday":3, "wednesday":4, "thursday":5, "friday":6, "saturday":7 }', '{ "january":1, "february":2, "march":3, "april":4, "may":5, "june":6, "july":7, "august":8, "september":9, "october":10, "november":11, "december":12 }')
GO


GO
CREATE TABLE [dbo].[schedule]
(
	[schedule_id]		INT				IDENTITY (1, 1) NOT NULL,
	[schedule_name]		VARCHAR (100)	NOT NULL,
	[schedule_type_id]	INT				NOT NULL,
	[is_active]			BIT				NOT NULL,
	[start_date_time]	DATETIME		NOT NULL,
	[end_date_time]		DATETIME		NULL,
	[recur_interval]	INT				NOT NULL,
	[repeat_for_mins]	INT				NULL,
	[repeat_end_time]	TIME			NULL,
	[days_json]			VARCHAR (450)	NULL,
	[weeks_json]		VARCHAR (75)	NULL,
	[weekdays_json]		VARCHAR (125)	NULL,
	[months_json]		VARCHAR (200)	NULL,
	[created_by]		VARCHAR (30)	NOT NULL,
	[created_stamp]		DATETIME		NOT NULL,
	[modified_by]		VARCHAR (30)	NOT NULL,
	[modified_stamp]	DATETIME		NOT NULL,

    CONSTRAINT	[pk_schedule] PRIMARY KEY CLUSTERED ([schedule_id] ASC),
    CONSTRAINT	[fk_schedule__schedule_type] FOREIGN KEY ([schedule_type_id]) REFERENCES [dbo].[schedule_type] ([schedule_type_id]),

	[start_date]			AS CAST([start_date_time] AS DATE) PERSISTED,
	[end_date]				AS CAST([end_date_time] AS DATE) PERSISTED,

	-- Computed column cannot be persisted because the column is non-deterministic due to combination of DATEADD & DATEPART.
	-- [start_date_weekstart_date]	AS DATEADD(DAY, CHOOSE(DATEPART(WEEKDAY, [start_date_time]), 0, -1, -2, -3, -4, -5, -6), [start_date_time]) PERSISTED,
	-- [start_date_monthstart_date] AS DATEADD(D, 1-DATEPART(D, s.[start_date]), s.[start_date])

	[start_date_weekstart_date]		AS CAST(DATEADD(DAY, 1 + CHOOSE((DATEDIFF(DAY, CONVERT(DATETIME,'1990-01-01', 120), [start_date_time]) % 7), -1, -2, -3, -4, -5, -6, 0), [start_date_time]) AS DATE) PERSISTED,
	[start_date_monthstart_date]	AS DATEFROMPARTS(YEAR([start_date_time]), MONTH([start_date_time]), 1) PERSISTED,

	[start_time_minutes]	AS (DATEPART(HOUR, [start_date_time]) * 60) + DATEPART(MINUTE, [start_date_time]) PERSISTED,
	[end_time_minutes]		AS ISNULL((DATEPART(HOUR, [end_date_time]) * 60) + DATEPART(MINUTE, [end_date_time]), 1439) PERSISTED,
	[repeat_end_time_minutes] AS ISNULL((DATEPART(HOUR, [repeat_end_time]) * 60) + DATEPART(MINUTE, [repeat_end_time]), 1439) PERSISTED
);
GO

