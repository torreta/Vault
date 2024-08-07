# Building Migrations

branch_sync_lists
php artisan make:migration create_branch_sync_lists_table

need:
branch_id : integer
active_client : boolean, default: false
consume_queue_name: string
publish_queue_name: string
active_queue: boolean, default: false
timestamps

task_types
php artisan make:migration create_task_types_table

need:
name: string
description: string
example: string
timestamp

seed:
1. ack "recibí task" (local)
2. ack "termine task"(local)
3. ack "recibí task" (cloud)
4. ack "termine task"(cloud)
5. sync catalog (local / cloud)
6. sync product (local / cloud)
7. sync inventory (local / cloud)
8. create invoice (local / cloud)
9. request inventory (local cloud)
10. sync cash register (local / cloud)

run:
php artisan db:seed --class=TaskTypeSeeder

task_statuses
php artisan make:migration create_task_statuses_table

need:
name: string
description: string
timestamps

seed:
1. 'creada'
2. 'enviada'
3. 'recibida',
4. 'completada'
5. 'fallida'

run:
php artisan db:seed --class=TaskStatusSeeder

task_histories
php artisan make:migration create_task_histories_table

need:
branch_id: integer
task_id: integer
task_type_id: integer
task_status_id: integer
timestamps

task_sources
php artisan make:migration create_task_sources_table

need:
name: string
description: string
timestamps

seed:
1. local
2. cloud

run:
php artisan db:seed --class=TaskSourcesSeeder

sync_tasks
php artisan make:migration create_sync_tasks_table

id: integer
remote_task_id: integer
branch_id: integer
task_type_id: integer
task_status_id: integer
task_history_id: integer
task_sender_source_id: integer
task_receiver_source_id: integer
task_start: datetime
task_end: datetime
task_duration: datetime
task_completed: boolean
task_succeeded: boolean
data: text
timestamps
