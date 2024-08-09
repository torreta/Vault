'use strict';
module.exports = (sequelize, DataTypes) => {
  const task_histories = sequelize.define('task_histories', {
    branch_id: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    task_id: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    task_type_id: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    task_status_id: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
  }, {
    timestamps: true
  });
  task_histories.associate = function(models) {
    // associations can be defined here
  };
  return task_histories;
};
