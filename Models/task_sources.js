'use strict';
module.exports = (sequelize, DataTypes) => {
  const task_sources = sequelize.define('task_sources', {
    name: {
      type: DataTypes.STRING,
      allowNull: false
    },
    description: DataTypes.STRING,
  }, {
    timestamps: true
  });
  task_sources.associate = function(models) {
    // associations can be defined here
  };
  return task_sources;
};
