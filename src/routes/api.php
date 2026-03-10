<?php

# use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\EventoController;
use App\Http\Controllers\PonenteController;
use App\Http\Controllers\AsistenteController;


#Route::get('/user', function (Request $request) {
#    return $request->user();
#})->middleware('auth:api');

#Route::apiResource('eventos', EventoController::class);

Route::get('/eventos', [EventoController::class, 'index']);
Route::post('/eventos', [EventoController::class, 'store']);
Route::get('/eventos/{id}', [EventoController::class, 'show']);
Route::put('/eventos/{id}', [EventoController::class, 'update']);
Route::delete('/eventos/{id}', [EventoController::class, 'destroy']);

Route::apiResource('ponentes', PonenteController::class);
Route::apiResource('asistentes', AsistenteController::class);


