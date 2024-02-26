<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Preguntas extends Model
{
    protected $table = 'programa';
    public $timestamps = false;

    protected $fillable = [
        'pregunta_id',
        'admin_id',
        'nombre',
        'descripcion',
        'horas_academicas',
        'docente',
        'institucion',
        'tipo_certificacion',
        'para_quienes',
        'created_at',
        'updated_at',
        'deleted_at'
    ];

    // Relación con el modelo Admin
    public function admin()
    {
        return $this->belongsTo(Admin::class, 'admin_id');
    }

    // Accesor para obtener el modelo Admin relacionado
    public function getAdminIdAttribute()
    {
        return Admin::find($this->admin_id);
    }
}
