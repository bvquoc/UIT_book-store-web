package main

import (
	"book-store-management-backend/component/appctx"
	"book-store-management-backend/component/config"
	"book-store-management-backend/component/database"
	"book-store-management-backend/server"

	"log"

	_ "github.com/joho/godotenv/autoload"
)

func main() {
	cfg := config.LoadConfig()

	connection := &database.RetryConnection{
		Strategy: &database.MySQLConnection{},
	}

	db, err := connection.Connect(cfg)
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}

	appCtx := appctx.NewAppContext(
		db,
		cfg.LogDir,
		cfg.SecretKey,
		cfg.StaticPath,
		cfg.ServerHost,
		cfg.EmailFrom,
		cfg.SMTPass,
		cfg.SMTHost,
		cfg.SMTPort)

	srv := server.NewServerBuilder(appCtx).
		SetReleaseMode().
		SetMiddlewares().
		SetRoutes().
		Build()

	srv.Serve(cfg.Port)
}
