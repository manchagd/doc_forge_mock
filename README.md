# Doc Forge Mock API

API mock para simular el servicio de generación de documentos.

## Endpoints

### Templates

#### Obtener todos los templates
```bash
curl http://localhost:3030/api/v1/templates
```

### Documents

#### Obtener tipos de documentos
```bash
curl http://localhost:3030/api/v1/documents/types
```

#### Procesar documento
```bash
curl -X POST http://localhost:3030/api/v1/documents/process \
  -H "Content-Type: application/json" \
  -d '{"template_id": "template-hipoteca"}'
```

#### Generar documento
```bash
curl -X POST http://localhost:3030/api/v1/documents/generate \
  -H "Content-Type: application/json" \
  -d '{"template_id": "template-hipoteca"}'
```

#### Descargar documento
```bash
curl -X GET http://localhost:3030/api/v1/documents/download -o downloaded_document.pdf
```

## Templates disponibles

- `template-hipoteca`: Solicitud de Hipoteca
- `template-arrendamiento`: Contrato de Arrendamiento
- `template-credito-vehicular`: Solicitud de Crédito Vehicular
