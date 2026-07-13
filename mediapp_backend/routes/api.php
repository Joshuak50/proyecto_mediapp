<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\LoginController as ControllersLoginController;
use App\Http\Controllers\CategoriaController;
use App\Http\Controllers\SubcategoriaController;
use App\Http\Controllers\UsuarioController;
use App\Models\Categoria;
use App\Models\Subcategoria;
Use App\Models\Usuario;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::post('login',[ControllersLoginController::class,'login']);

Route::get('categorias',[CategoriaController::class,'listAPI']);
Route::post('categoria',[CategoriaController::class,'getAPI']);
Route::post('categoria/guardar',[CategoriaController::class,'saveAPI']);
//Route::post('categoria/actu',[CategoriaController::class,'updateAPI']);
Route::put('categoria/{id}/actu',[CategoriaController::class,'updateAPI']);
Route::delete('categoria/{id}/borrar',[CategoriaController::class,'deleteAPI']);

Route::get('subcategorias',[SubcategoriaController::class,'listAPI']);
Route::post('subcategoria',[SubcategoriaController::class,'getAPI']);
Route::post('subcategoria/guardar',[SubcategoriaController::class,'saveAPI']);
Route::put('subcategoria/{id}/actu',[SubcategoriaController::class,'updateAPI']);
Route::delete('subcategoria/{id}/borrar',[SubcategoriaController::class,'deleteAPI']);

Route::post('usuarios/guardar', [UsuarioController::class, 'saveApi']);
Route::get('/usuario/{email}', [UsuarioController::class, 'getUsuario']);
Route::get('subcategoria/monto',[SubcategoriaController::class, 'getTotalMontoAPI']);

Route::get('/user/{id}', [UsuarioController::class, 'getUser']);

Route::get('/image/{filename}', function ($filename) {
    // Construir la ruta completa utilizando el nombre de archivo con el prefijo 'usuarios/'
    $path = storage_path('app/public/' . $filename);

    // Verifica si el archivo existe en la ruta
    if (file_exists($path)) {
        return response()->file($path); // Devuelve el archivo
    } else {
        return response()->json(['error' => 'Imagen no encontrada'], 404); // Si no se encuentra la imagen
    }
});