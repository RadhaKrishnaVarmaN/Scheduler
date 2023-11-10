# Scheduler
This repository contains a SQL script for creating tables related to scheduling in a SQL Server database.
* schedule_create_tables.sql
* usp_schedule_generate.sql
* schedule_json_data.sql (Sample Data)


## Schedule Table Creation Script Overview
The schedule_create_tables.sql script creates several tables that are necessary for managing schedules. These tables include:

* schedule: This table holds the main schedule information, such as the schedule name, start and end dates, recurrence details, and other related data.

* schedule_type: This table defines the different types of schedules that can be created, such as daily, weekly, or monthly schedules.

* schedule_detail: This table holds detailed information for each schedule, such as the specific days of the week or month when the schedule should run.

* Other related tables as defined in the script.


## Schedule Generator Script Overview
The dbo.usp_schedule_generate stored procedure is designed to generate schedules based on recrurrence and repeat  conditions.

* One-Time Scheule: The schedule type ID is 10

* Daily Schedule: The schedule type ID is 20, the recurrence interval is greater than 0, and either the recurrence interval is 1 or the number of days since the start date is divisible by the recurrence interval. The current day must also match the day specified in the days_json field of the schedule.

* Weekly schedules: The schedule type ID is 30, the recurrence interval is greater than 0, and either the recurrence interval is 1 or the number of weeks since the start date is divisible by the recurrence interval. The current weekday must also match the weekday specified in the weekdays_json field of the schedule.

* Monthly schedules (by days): The schedule type ID is 40, the recurrence interval is greater than 0, and either the recurrence interval is 1 or the number of months since the start date is divisible by the recurrence interval. The current month must match the month specified in the months_json field, and the current day must match the day specified in the days_json field, or it must be the end of the month and the days_json field must contain the value 32 for the key "last".

* Repeat conditions: If the repeat_for_mins field is 0 (indicating a one-time schedule), the current time in minutes must match the start time of the schedule. If repeat_for_mins is greater than 0 (indicating a repeating schedule), the difference between the current time in minutes and the start time of the schedule must be divisible by repeat_for_mins.


## Contributing
Contributions are welcome. Please open an issue or submit a pull request if you have any improvements or suggestions.
