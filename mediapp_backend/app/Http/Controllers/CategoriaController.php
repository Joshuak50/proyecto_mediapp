<?php

namespace App\Http\Controllers;

use App\Models\Categoria;
use App\Models\Log as ModelsLog;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class CategoriaController extends Controller
{
    public function index(Request $req){
        Log::info('Accediendo al método index', ['request' => $req->all()]);

        if($req->id){
            $categoria = Categoria::find($req->id);
        }
        else{
            $categoria = new Categoria();
        }
        return view('categoria',compact('categoria'));
}
public function getAPI(Request $req){
    Log::info('Obteniendo medicamento', ['id' => $req->id]);

    $categoria = Categoria::find($req->id);
    return response()->json($categoria);
}

public function listAPI(Request $request) {
    Log::info('Listando medicamentos del usuario', ['user_id' => $request->query('user_id')]);
    $userId = $request->query('user_id');

    if (!$userId) {
        Log::warning('Falta el parámetro user_id en la solicitud');
        return response()->json([
            'message' => 'Falta el parámetro user_id',
            'data' => []
        ], 400);
    }
    
    $categorias = Categoria::where('id_usuario', $userId)->get();

    return response()->json([
        'message' => 'Categorías obtenidas correctamente',
        'data' => $categorias,
    ], 200);
}

public function saveAPI(Request $req){
    Log::info('Guardando medicamento', ['request' => $req->all()]);

    if($req->id !=0){
        $categoria = Categoria::find($req->id);
        Log::info('Actualizando medicamento existente', ['id' => $req->id]);
    }
    else{
        $categoria = new Categoria();
        Log::info('Creando nuevo medicamento');
    }
    
    $categoria -> nombre = $req->Nombre;
    $categoria -> descripcion = $req->Descripcion;
    $categoria -> fecha = $req->Fecha;
    $categoria -> hora = $req->Hora;
    $categoria -> dosis = $req->Dosis;
    $categoria -> frecuencia = $req->Frecuencia;
    $categoria -> frecuenciaDias = $req->FrecuenciaDias;
    $categoria -> alergia = $req->Alergia;
    $categoria -> otraAlergia = $req->OtraAlergia;
    $categoria -> id_usuario = $req->id_usuario;
    $categoria->save();  
    Log::info('Medicamento guardada correctamente', ['id' => $categoria->id]);

    ModelsLog::create([
        'accion' => 'Registro de medicamento',
        'detalles' => json_encode(['medicamento' => $categoria->nombre])
    ]);

    return "ok";
}
public function updateAPI(Request $req, $id){
    Log::info('Actualizando medicamento', ['request' => $req->all(), 'id' => $id]);

    if($req->id !=0){
        $categoria = Categoria::find($req->id);
    }
    else{
        $categoria = new Categoria();
    }
    $categoria -> id = $req->id;
    $categoria -> nombre = $req->nombre;
    $categoria -> descripcion = $req->descripcion;
    $categoria -> fecha = $req->fecha;
    $categoria -> hora = $req->hora;
    $categoria -> dosis = $req->dosis;
    $categoria -> frecuencia = $req->frecuencia;
    $categoria -> frecuenciaDias = $req->frecuenciaDias;
    $categoria -> alergia = $req->alergia;
    $categoria -> otraAlergia = $req->otraAlergia;
    $categoria -> id_usuario = $req->id_usuario;
    $categoria->save();  
    Log::info('Medicamento actualizada correctamente', ['id' => $categoria->id]);

    return "ok";

}
public function deleteAPI(Request $req){
    Log::info('Eliminando medicamento', ['id' => $req->id]);
    $categoria = Categoria::find($req->id);
    $categoria->delete();
    Log::info('Medicamento eliminada correctamente', ['id' => $req->id]);
    return "ok";

}
}
