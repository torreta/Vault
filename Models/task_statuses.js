'use strict';
module.exports = (sequelize, DataTypes) => {
  const task_statuses = sequelize.define('task_statuses', {
    name: {
      type: DataTypes.STRING,
      allowNull: false
    },
    description: DataTypes.STRING,
  }, {
    timestamps: true
  });
  task_statuses.associate = function(models) {
    // associations can be defined here
  };
  return task_statuses;
};
