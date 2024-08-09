'use strict';
module.exports = (sequelize, DataTypes) => {
  const task_types = sequelize.define('task_types', {
    name: {
      type: DataTypes.STRING,
      allowNull: false
    },
    description: DataTypes.STRING,
    example: DataTypes.STRING,
  }, {});
  task_types.associate = function(models) {
    // associations can be defined here
  };
  return task_types;
};
