package server

import (
	"fmt"
	"log"

	"book-store-management-backend/component/appctx"
	"book-store-management-backend/middleware"
	factory "book-store-management-backend/server/factory"

	"github.com/gin-gonic/gin"
)

type ConcreteServerBuilder struct {
	router *gin.Engine
	appCtx appctx.AppContext
}

func NewServerBuilder(appCtx appctx.AppContext) *ConcreteServerBuilder {
	return &ConcreteServerBuilder{
		router: gin.New(),
		appCtx: appCtx,
	}
}

func (b *ConcreteServerBuilder) SetMiddlewares() ServerBuilder {
	b.router.Use(middleware.CORSMiddleware())
	b.router.Use(middleware.Recover(b.appCtx))
	return b
}

func (b *ConcreteServerBuilder) SetRoutes() ServerBuilder {
	factory.SetupModuleRoutes(b.router, b.appCtx)
	return b
}

func (b *ConcreteServerBuilder) Build() *Server {
	return &Server{
		router: b.router,
		appCtx: b.appCtx,
	}
}

type Server struct {
	router *gin.Engine
	appCtx appctx.AppContext
}

// @title           Book Store Management API
// @description     This is a sample server Book Store Management API server.
// @version         1.0
// @contact.name   Bui Vi Quoc
// @contact.url    https://www.facebook.com/bviquoc/
// @contact.email  21520095@gm.uit.edu.vn
// @host localhost:8080
// @BasePath  /v1
// @securityDefinitions.apikey BearerAuth
// @in header
// @name Authorization
func (s *Server) Serve(port string) {
	if err := s.router.Run(fmt.Sprintf(":%s", port)); err != nil {
		log.Fatalf("Failed to run the server: %v", err)
	}
}
