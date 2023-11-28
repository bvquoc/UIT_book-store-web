// Package docs Code generated by swaggo/swag. DO NOT EDIT
package docs

import "github.com/swaggo/swag"

const docTemplate = `{
    "schemes": {{ marshal .Schemes }},
    "swagger": "2.0",
    "info": {
        "description": "{{escape .Description}}",
        "title": "{{.Title}}",
        "contact": {
            "name": "Bui Vi Quoc",
            "url": "https://www.facebook.com/bviquoc/",
            "email": "21520095@gm.uit.edu.vn"
        },
        "version": "{{.Version}}"
    },
    "host": "{{.Host}}",
    "basePath": "{{.BasePath}}",
    "paths": {
        "/authors": {
            "get": {
                "security": [
                    {
                        "BearerAuth": []
                    }
                ],
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "authors"
                ],
                "summary": "Get all authors",
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/authormodel.ResListAuthor"
                        }
                    }
                }
            },
            "post": {
                "security": [
                    {
                        "BearerAuth": []
                    }
                ],
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "authors"
                ],
                "summary": "Create author with name",
                "parameters": [
                    {
                        "description": "Create author",
                        "name": "author",
                        "in": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/authormodel.ReqCreateAuthor"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "author id",
                        "schema": {
                            "$ref": "#/definitions/authormodel.ResCreateAuthor"
                        }
                    }
                }
            }
        }
    },
    "definitions": {
        "authormodel.Author": {
            "type": "object",
            "properties": {
                "id": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                }
            }
        },
        "authormodel.Filter": {
            "type": "object",
            "properties": {
                "searchKey": {
                    "type": "string"
                }
            }
        },
        "authormodel.ReqCreateAuthor": {
            "type": "object",
            "properties": {
                "name": {
                    "type": "string",
                    "example": "Nguyễn Nhật Ánh"
                }
            }
        },
        "authormodel.ResCreateAuthor": {
            "type": "object",
            "properties": {
                "id": {
                    "type": "string"
                }
            }
        },
        "authormodel.ResListAuthor": {
            "type": "object",
            "properties": {
                "data": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/authormodel.Author"
                    }
                },
                "filter": {
                    "$ref": "#/definitions/authormodel.Filter"
                },
                "paging": {
                    "$ref": "#/definitions/common.Paging"
                }
            }
        },
        "common.Paging": {
            "type": "object",
            "properties": {
                "limit": {
                    "type": "integer"
                },
                "page": {
                    "type": "integer"
                },
                "total": {
                    "type": "integer"
                }
            }
        }
    },
    "securityDefinitions": {
        "BearerAuth": {
            "type": "apiKey",
            "name": "Authorization",
            "in": "header"
        }
    }
}`

// SwaggerInfo holds exported Swagger Info so clients can modify it
var SwaggerInfo = &swag.Spec{
	Version:          "1.0",
	Host:             "localhost:8080",
	BasePath:         "/v1",
	Schemes:          []string{},
	Title:            "Book Store Management API",
	Description:      "",
	InfoInstanceName: "swagger",
	SwaggerTemplate:  docTemplate,
	LeftDelim:        "{{",
	RightDelim:       "}}",
}

func init() {
	swag.Register(SwaggerInfo.InstanceName(), SwaggerInfo)
}
