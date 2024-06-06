package database

import (
	"fmt"
	"log"
	"time"

	"book-store-management-backend/component/config"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

type ConnectionStrategy interface {
	Connect(cfg *config.AppConfig) (*gorm.DB, error)
}

type MySQLConnection struct{}

func (m *MySQLConnection) Connect(cfg *config.AppConfig) (*gorm.DB, error) {
	dsn := fmt.Sprintf("%s:%s@tcp(%s)/%s?charset=utf8mb4&parseTime=True&loc=Local",
		cfg.DBUsername, cfg.DBPassword, cfg.DBHost, cfg.DBDatabase)
	return gorm.Open(mysql.Open(dsn), &gorm.Config{})
}

type RetryConnection struct {
	Strategy ConnectionStrategy
}

func (r *RetryConnection) Connect(cfg *config.AppConfig) (*gorm.DB, error) {
	const retryDuration = 60 * time.Second
	deadline := time.Now().Add(retryDuration)
	var db *gorm.DB
	var err error

	for attempts := 0; time.Now().Before(deadline); attempts++ {
		db, err = r.Strategy.Connect(cfg)
		if err == nil {
			log.Printf("Database connected after %d attempt(s)", attempts+1)
			if cfg.Env == "dev" {
				db = db.Debug()
			}
			return db, nil
		}
		time.Sleep(2 * time.Second)
		log.Printf("Retrying to connect to database: attempt %d", attempts+1)
	}

	return nil, fmt.Errorf("failed to connect to database after %d seconds: %w", retryDuration, err)
}
