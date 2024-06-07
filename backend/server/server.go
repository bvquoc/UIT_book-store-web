package server

import (
	"fmt"
	"log"

	"book-store-management-backend/component/appctx"

	"github.com/gin-gonic/gin"
)

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
