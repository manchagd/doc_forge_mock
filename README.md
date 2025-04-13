# Doc Forge Mock API

API mock para simular el servicio de generación de documentos.

## Documentación API

La documentación de la API está disponible en Swagger UI:

```bash
# Acceder a la documentación Swagger
http://localhost:3030/api-docs
```

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

## Verificar estado del servidor

```bash
curl http://localhost:3030/up
```

# GET /api/templates

Response:
{ templates:
[
  {
    "id": "xxxx-xxxx-xxxx-xxxx",
    "name": "Template 1",
    "description": "Template 1 description",
    "gdrive_id": "xxxx-xxxx-xxxx-xxxx",
    "documents": [
      {
        "document_type": "CC",
        "fields": [
          {
            "name": "Field 1",
            "description": "Field 1 description",
            "required": true
          },
          {
            "name": "Field 2",
            "description": "Field 2 description",
            "required": false
          }
        ]
      },
      {
        "document_type": "Owne",
        "fields": [
          {
            "name": "Field 3",
            "description": "Field 3 description",
            "required": true
          },
          {
            "name": "Field 4",
            "description": "Field 4 description",
            "required": true
          }
        ]
      }
    ]
  },
]
}

# POST /api/documents/process
Request:
{
  "template_id": "xxxx-xxxx-xxxx-xxxx",
  "uploaded_files": [
    {
      "document_type": "CC",
      "base64": "as...==",
      "file_name": "test.pdf"
    },
    {
      "document_type": "Owner",
      "base64": "as...==",
      "file_name": "test.png"
    }
  ]
}

Response:
{
  "documents": [
    {
      "document_type": "CC",
      "fields": [
        {
          "name": "Field 1",
          "value": "Value 1"
        },
        {
          "name": "Field 2",
          "value": "Value 2"
        }
      ]
    },
    {
      "document_type": "Owner",
      "fields": [
        {
          "name": "Field 3",
          "value": "Value 3"
        },
        {
          "name": "Field 4",
          "value": "Value 4"
        }
      ]
    }
  ]
}

# POST /api/documents/generate
Request:
{
  "template_id": "xxxx-xxxx-xxxx-xxxx",
  "fields": [
    {
      "name": "Field 1",
      "value": "Value 1"
    },
    {
      "name": "Field 2",
      "value": "Value 2"
    },
    {
      "name": "Field 3",
      "value": "Value 3"
    },
    {
      "name": "Field 4",
      "value": "Value 4"
    }
  ]
}

Response:
{
  "generated_document": {
    "name": "generated.pdf",
    "gdrive_id": "xxxx-xxxx-xxxx-xxxx",
    "url": "https://www.google.com"
  }
}


# POST /api/documents/download
Request:
{
  "gdrive_id": "xxxx-xxxx-xxxx-xxxx"
}

Response:
PDF-blob
```
