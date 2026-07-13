<?php

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Auth::routes();

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

Route::get('/test', function () {
    $imagen = DB::table('usuarios')->select('imagen')->first();
    return response()->json($imagen);
});

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