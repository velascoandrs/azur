import json
import os
from pathlib import Path


def crear_datos(ruta, model, nombreEntidad=''):
    print(f'creado {nombreEntidad}')
    registros = cargarArchivo(ruta)
    listaObjetos = []
    for registro in registros:
        listaObjetos.append(
            model(**registro)
        )
    model.objects.bulk_create(
        listaObjetos
    )


def cargarArchivo(rutaArchivo):
    rutaArchivoFormateada = Path(rutaArchivo)
    path = Path(os.getcwd())
    ruta = os.path.join(path, rutaArchivoFormateada)
    with open(ruta, 'r',  encoding="utf8") as archivo:
        return json.load(archivo)