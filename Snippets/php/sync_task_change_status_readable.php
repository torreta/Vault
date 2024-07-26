 public function change_status($task_id, $new_status_string )
    {
        // STATUSES
        // 1. 'creada'
        // 2. 'enviada'
        // 3. 'recibida',
        // 4. 'completada'
        // 5. 'fallida'
                
        // asegurándome que este en mayúsculas
        $new_status_string = strtoupper($new_status_string);

        switch ($new_status_string) {
            case 'CREADA':
                $status_id = 1;
                break;
            
            case 'ENVIADA':
                $status_id = 2;
                break;
            
            case 'RECIBIDA':
                $status_id = 3;
                break;
            
            case 'COMPLETADA':
                $status_id = 4;
                break;
            
            case 'FALLIDA':
                $status_id = 5;
                break;
    
            default:
                Log::info("estatus de orden invalido creando orden");
                break;
        }
    
        // task al cual me refiero
        $sync_task = SyncTask::find($task_id);
        
        // new status history
        $new_status = new TaskHistory();
        $new_status->branch_id = $sync_task->branch_id;
        $new_status->task_id = $sync_task->id;
        $new_status->task_type_id = $sync_task->task_type_id;
        $new_status->task_status_id = $status_id;
        
        $new_status->save();


        // updating the task
        $sync_task->task_status_id = $status_id;
        $sync_task->task_history_id = $new_status->id;


        return $sync_task->save();

    }