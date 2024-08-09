'use strict';
module.exports = (sequelize, DataTypes) => {
  const sync_tasks = sequelize.define('sync_tasks', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    remote_task_id: DataTypes.INTEGER,
    branch_id: DataTypes.INTEGER,
    task_type_id: DataTypes.INTEGER,
    task_status_id: DataTypes.INTEGER,
    task_history_id: DataTypes.INTEGER,
    task_sender_source_id: DataTypes.INTEGER,
    task_receiver_source_id: DataTypes.INTEGER,
    task_start: DataTypes.DATE,
    task_end: DataTypes.DATE,
    task_duration: DataTypes.DATE,
    task_completed: DataTypes.BOOLEAN,
    task_succeeded: DataTypes.BOOLEAN,
    data: DataTypes.TEXT,
  }, {});
  sync_tasks.associate = function(models) {
    // associations can be defined here
  };
  return sync_tasks;
};
