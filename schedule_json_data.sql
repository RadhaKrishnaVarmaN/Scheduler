DECLARE	@days_json		VARCHAR (450) = NULL
DECLARE	@weeks_json		VARCHAR (75)  =	NULL
DECLARE	@weekdays_json	VARCHAR (125) =	NULL
DECLARE	@months_json	VARCHAR (200) =	NULL

SET @days_json		= '{ "day01":1, "day02":2, "day03":3, "day04":4, "day05":5, "day06":6, "day07":7, "day08":8, "day09":9, "day10":10, "day11":11, "day12":12, "day13":13, "day14":14, "day15":15, "day16":16, "day17":17, "day18":18, "day19":19, "day20":20, "day21":21, "day22":22, "day23":23, "day24":24, "day25":25, "day26":26, "day27":27, "day28":28, "day29":29, "day30":30, "day31":31, "last":32}'
SET @weeks_json		= '{ "first":1, "second":2, "third":3, "fourth":4, "last":5 }'
SET @weekdays_json	= '{ "sunday":1, "monday":2, "tuesday":3, "wednesday":4, "thrusday":5, "friday":6, "saturday":7 }'
SET @months_json	= '{ "january":1, "february":2, "march":3, "april":4, "may":5, "june":6, "july":7, "august":8, "september":9, "october":10, "november":11, "december":12 }'

SELECT days_json = @days_json, weeks_json = @weeks_json, weekdays_json = @weekdays_json, months_json = @months_json


/*
INSERT INTO dbo.schedule(schedule_name, schedule_type_id, is_active, start_date_time, end_date_time, recur_interval, repeat_for_mins, repeat_end_time, days_json, weeks_json, weekdays_json, months_json, created_by, created_stamp, modified_by, modified_stamp)
SELECT
	  schedule_name		= CONCAT('One-Time on ', FORMAT(GETDATE(), 'MM-dd-yyyy'))
	, schedule_type_id	= 10
	, is_active			= 1
	, start_date_time	= DATEADD(HOUR, 1, GETDATE())
	, end_date_time		= NULL
	, recur_interval	= 0
	, repeat_for_mins	= NULL
	, repeat_end_time	= NULL
	, days_json			= NULL
	, weeks_json		= NULL
	, weekdays_json		= NULL
	, months_json		= NULL
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
UNION ALL
SELECT
	  schedule_name		= CONCAT('One-Time on ', FORMAT(GETDATE(), 'MM-dd-yyyy'), ' with repeat for mins = 10')
	, schedule_type_id	= 10
	, is_active			= 1
	, start_date_time	= GETDATE()
	, end_date_time		= NULL
	, recur_interval	= 0
	, repeat_for_mins	= 10
	, repeat_end_time	= NULL
	, days_json			= NULL
	, weeks_json		= NULL
	, weekdays_json		= NULL
	, months_json		= NULL
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
UNION ALL
SELECT
	  schedule_name		= CONCAT('One-Time on ', FORMAT(GETDATE(), 'MM-dd-yyyy'), ' with repeat for mins = 30 and repeat end time = 10 PM')
	, schedule_type_id	= 10
	, is_active			= 1
	, start_date_time	= GETDATE()
	, end_date_time		= NULL
	, recur_interval	= 0
	, repeat_for_mins	= 30
	, repeat_end_time	= N'22:00:00'
	, days_json			= NULL
	, weeks_json		= NULL
	, weekdays_json		= NULL
	, months_json		= NULL
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
GO

INSERT INTO dbo.schedule(schedule_name, schedule_type_id, is_active, start_date_time, end_date_time, recur_interval, repeat_for_mins, repeat_end_time, days_json, weeks_json, weekdays_json, months_json, created_by, created_stamp, modified_by, modified_stamp)
SELECT
	  schedule_name		= 'Daily'
	, schedule_type_id	= 20
	, is_active			= 1
	, start_date_time	= DATEADD(HOUR, 1, GETDATE())
	, end_date_time		= NULL
	, recur_interval	= 1
	, repeat_for_mins	= NULL
	, repeat_end_time	= NULL
	, days_json			= NULL
	, weeks_json		= NULL
	, weekdays_json		= NULL
	, months_json		= NULL
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
UNION ALL
SELECT
	  schedule_name		= 'Daily with repeat for mins = 30'
	, schedule_type_id	= 20
	, is_active			= 1
	, start_date_time	= GETDATE() - 1
	, end_date_time		= NULL
	, recur_interval	= 1
	, repeat_for_mins	= 30
	, repeat_end_time	= NULL
	, days_json			= NULL
	, weeks_json		= NULL
	, weekdays_json		= NULL
	, months_json		= NULL
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
UNION ALL
SELECT
	  schedule_name		= 'Daily with repeat for mins = 30 and repeat end time = 11 PM'
	, schedule_type_id	= 20
	, is_active			= 1
	, start_date_time	= GETDATE() - 1
	, end_date_time		= NULL
	, recur_interval	= 1
	, repeat_for_mins	= 30
	, repeat_end_time	= N'23:00:00'
	, days_json			= NULL
	, weeks_json		= NULL
	, weekdays_json		= NULL
	, months_json		= NULL
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
GO

INSERT INTO dbo.schedule(schedule_name, schedule_type_id, is_active, start_date_time, end_date_time, recur_interval, repeat_for_mins, repeat_end_time, days_json, weeks_json, weekdays_json, months_json, created_by, created_stamp, modified_by, modified_stamp)
SELECT
	  schedule_name		= 'Weekly'
	, schedule_type_id	= 30
	, is_active			= 1
	, start_date_time	= GETDATE() --DATEADD(HOUR, 1, GETDATE())
	, end_date_time		= NULL
	, recur_interval	= 1
	, repeat_for_mins	= NULL
	, repeat_end_time	= NULL
	, days_json			= NULL --'{"day01":1,"day02":2,"day03":3,"day04":4,"day05":5,"day06":6,"day07":7,"day08":8,"day09":9,"day10":10,"day11":11,"day12":12,"day13":13,"day14":14,"day15":15,"day16":16,"day17":17,"day18":18,"day19":19,"day20":20,"day21":21,"day22":22,"day23":23,"day24":24,"day25":25,"day26":26,"day27":27,"day28":28,"day29":29,"day30":30,"day31":31,"last":32}'
	, weeks_json		= NULL
	, weekdays_json		= '{"sunday":1,"monday":2,"tuesday":3,"wednesday":4,"thrusday":5,"friday":6,"saturday":7}'
	, months_json		= NULL
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
UNION ALL
SELECT
	  schedule_name		= 'Weekly with repeat for mins = 30'
	, schedule_type_id	= 30
	, is_active			= 1
	, start_date_time	= GETDATE() - 1
	, end_date_time		= NULL
	, recur_interval	= 1
	, repeat_for_mins	= 30
	, repeat_end_time	= NULL
	, days_json			= NULL
	, weeks_json		= NULL
	, weekdays_json		= '{"sunday":1,"monday":2,"tuesday":3,"wednesday":4,"thrusday":5,"friday":6,"saturday":7}'
	, months_json		= NULL
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
UNION ALL
SELECT
	  schedule_name		= 'Weekly with repeat for mins = 30 and repeat end time = 11 AM'
	, schedule_type_id	= 30
	, is_active			= 1
	, start_date_time	= GETDATE() - 1
	, end_date_time		= NULL
	, recur_interval	= 1
	, repeat_for_mins	= 30
	, repeat_end_time	= N'11:00:00'
	, days_json			= NULL
	, weeks_json		= NULL
	, weekdays_json		= '{"sunday":1,"monday":2,"tuesday":3,"wednesday":4,"thrusday":5,"friday":6,"saturday":7}'
	, months_json		= NULL
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
GO

INSERT INTO dbo.schedule(schedule_name, schedule_type_id, is_active, start_date_time, end_date_time, recur_interval, repeat_for_mins, repeat_end_time, days_json, weeks_json, weekdays_json, months_json, created_by, created_stamp, modified_by, modified_stamp)
SELECT
	  schedule_name		= 'Weekly with recur interval = 2 and starting last week'
	, schedule_type_id	= 30
	, is_active			= 1
	, start_date_time	= DATEADD(DAY, -1, GETDATE())
	, end_date_time		= NULL
	, recur_interval	= 2
	, repeat_for_mins	= NULL
	, repeat_end_time	= NULL
	, days_json			= NULL
	, weeks_json		= NULL
	, weekdays_json		= '{"sunday":1}'
	, months_json		= NULL
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
UNION ALL
SELECT
	  schedule_name		= 'Weekly with recur interval = 2 weeks and on sunday'
	, schedule_type_id	= 30
	, is_active			= 1
	, start_date_time	= DATEADD(DAY, -8, GETDATE())
	, end_date_time		= NULL
	, recur_interval	= 2
	, repeat_for_mins	= NULL
	, repeat_end_time	= NULL
	, days_json			= NULL
	, weeks_json		= NULL
	, weekdays_json		= '{"sunday":1}'
	, months_json		= NULL
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
UNION ALL
SELECT
	  schedule_name		= 'Weekly with recur interval = 2 weeks and except sunday'
	, schedule_type_id	= 30
	, is_active			= 1
	, start_date_time	= DATEADD(DAY, -8, GETDATE())
	, end_date_time		= NULL
	, recur_interval	= 2
	, repeat_for_mins	= NULL
	, repeat_end_time	= NULL
	, days_json			= NULL
	, weeks_json		= NULL
	, weekdays_json		= '{"monday":2,"tuesday":3,"wednesday":4,"thrusday":5,"friday":6,"saturday":7}'
	, months_json		= NULL
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
GO

INSERT INTO dbo.schedule(schedule_name, schedule_type_id, is_active, start_date_time, end_date_time, recur_interval, repeat_for_mins, repeat_end_time, days_json, weeks_json, weekdays_json, months_json, created_by, created_stamp, modified_by, modified_stamp)
SELECT
	  schedule_name		= 'Monthly-Days'
	, schedule_type_id	= 40
	, is_active			= 1
	, start_date_time	= GETDATE()
	, end_date_time		= NULL
	, recur_interval	= 1
	, repeat_for_mins	= NULL
	, repeat_end_time	= NULL
	, days_json			= '{"day01":1,"day02":2,"day03":3,"day04":4,"day05":5,"day06":6,"day07":7,"day08":8,"day09":9,"day10":10,"day11":11,"day12":12,"day13":13,"day14":14,"day15":15,"day16":16,"day17":17,"day18":18,"day19":19,"day20":20,"day21":21,"day22":22,"day23":23,"day24":24,"day25":25,"day26":26,"day27":27,"day28":28,"day29":29,"day30":30,"day31":31,"last":32}'
	, weeks_json		= NULL
	, weekdays_json		= NULL
	, months_json		= '{"january":1,"february":2,"march":3,"april":4,"may":5,"june":6,"july":7,"august":8,"september":9,"october":10,"november":11,"december":12}'
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
UNION ALL
SELECT
	  schedule_name		= 'Monthly-Days with recur interval = 2 months'
	, schedule_type_id	= 40
	, is_active			= 1
	, start_date_time	= DATEADD(MONTH, -1, GETDATE())
	, end_date_time		= NULL
	, recur_interval	= 2
	, repeat_for_mins	= NULL
	, repeat_end_time	= NULL
	, days_json			= '{"day01":1,"day02":2,"day03":3,"day04":4,"day05":5,"day06":6,"day07":7,"day08":8,"day09":9,"day10":10,"day11":11,"day12":12,"day13":13,"day14":14,"day15":15,"day16":16,"day17":17,"day18":18,"day19":19,"day20":20,"day21":21,"day22":22,"day23":23,"day24":24,"day25":25,"day26":26,"day27":27,"day28":28,"day29":29,"day30":30,"day31":31,"last":32}'
	, weeks_json		= NULL
	, weekdays_json		= NULL
	, months_json		= '{"january":1,"february":2,"march":3,"april":4,"may":5,"june":6,"july":7,"august":8,"september":9,"october":10,"november":11,"december":12}'
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
UNION ALL
SELECT
	  schedule_name		= 'Monthly-Days with recur interval = 3 months'
	, schedule_type_id	= 40
	, is_active			= 1
	, start_date_time	= DATEADD(MONTH, -2, GETDATE())
	, end_date_time		= NULL
	, recur_interval	= 2
	, repeat_for_mins	= NULL
	, repeat_end_time	= NULL
	, days_json			= '{"day01":1,"day02":2,"day03":3,"day04":4,"day05":5,"day06":6,"day07":7,"day08":8,"day09":9,"day10":10,"day11":11,"day12":12,"day13":13,"day14":14,"day15":15,"day16":16,"day17":17,"day18":18,"day19":19,"day20":20,"day21":21,"day22":22,"day23":23,"day24":24,"day25":25,"day26":26,"day27":27,"day28":28,"day29":29,"day30":30,"day31":31,"last":32}'
	, weeks_json		= NULL
	, weekdays_json		= NULL
	, months_json		= '{"january":1,"february":2,"march":3,"april":4,"may":5,"june":6,"july":7,"august":8,"september":9,"october":10,"november":11,"december":12}'
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
GO

INSERT INTO dbo.schedule(schedule_name, schedule_type_id, is_active, start_date_time, end_date_time, recur_interval, repeat_for_mins, repeat_end_time, days_json, weeks_json, weekdays_json, months_json, created_by, created_stamp, modified_by, modified_stamp)
SELECT
	  schedule_name		= 'Monthly-Days Last Day'
	, schedule_type_id	= 40
	, is_active			= 1
	, start_date_time	= GETDATE()
	, end_date_time		= NULL
	, recur_interval	= 1
	, repeat_for_mins	= NULL
	, repeat_end_time	= NULL
	, days_json			= '{"last":32}'
	, weeks_json		= NULL
	, weekdays_json		= NULL
	, months_json		= '{"january":1,"february":2,"march":3,"april":4,"may":5,"june":6,"july":7,"august":8,"september":9,"october":10,"november":11,"december":12}'
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
UNION ALL
SELECT
	  schedule_name		= 'Monthly-Days Last Day with recur interval = 2 months'
	, schedule_type_id	= 40
	, is_active			= 1
	, start_date_time	= DATEADD(MONTH, -1, GETDATE())
	, end_date_time		= NULL
	, recur_interval	= 2
	, repeat_for_mins	= NULL
	, repeat_end_time	= NULL
	, days_json			= '{"last":32}'
	, weeks_json		= NULL
	, weekdays_json		= NULL
	, months_json		= '{"january":1,"february":2,"march":3,"april":4,"may":5,"june":6,"july":7,"august":8,"september":9,"october":10,"november":11,"december":12}'
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
UNION ALL
SELECT
	  schedule_name		= 'Monthly-Days Last Day with recur interval = 3 months'
	, schedule_type_id	= 40
	, is_active			= 1
	, start_date_time	= DATEADD(MONTH, -2, GETDATE())
	, end_date_time		= NULL
	, recur_interval	= 2
	, repeat_for_mins	= NULL
	, repeat_end_time	= NULL
	, days_json			= '{"last":32}'
	, weeks_json		= NULL
	, weekdays_json		= NULL
	, months_json		= '{"january":1,"february":2,"march":3,"april":4,"may":5,"june":6,"july":7,"august":8,"september":9,"october":10,"november":11,"december":12}'
	, created_by		= 'rnadimpalli'
	, created_stamp		= GETDATE()
	, modified_by		= 'rnadimpalli'
	, modified_stamp	= GETDATE()
GO


*/

