package config

import (
	"log"
	"strconv"
	"sync"

	"github.com/joho/godotenv"
)

var (
	instance *AppConfig
	once     sync.Once
)

type AppConfig struct {
	Port       string
	Env        string
	LogDir     string
	StaticPath string
	ServerHost string
	DBUsername string
	DBPassword string
	DBHost     string
	DBDatabase string
	SecretKey  string
	EmailFrom  string
	SMTPUser   string
	SMTPass    string
	SMTHost    string
	SMTPort    int
}

func LoadConfig() *AppConfig {
	once.Do(func() {
		instance = &AppConfig{}
		env, err := godotenv.Read()
		if err != nil {
			log.Fatalln("Error when loading .env", err)
		}

		{
			port, _ := strconv.Atoi(env["SMTPORT"])
			instance.Port = env["PORT"]
			instance.Env = env["GO_ENV"]
			instance.LogDir = env["LOG_DIR"] + "/"
			instance.StaticPath = env["STATIC_PATH"]
			instance.ServerHost = env["SERVER_HOST"]
			instance.DBUsername = env["DB_USERNAME"]
			instance.DBPassword = env["DB_PASSWORD"]
			instance.DBHost = env["DB_HOST"]
			instance.DBDatabase = env["DB_DATABASE"]
			instance.SecretKey = env["SECRET_KEY"]
			instance.EmailFrom = env["EMAILFROM"]
			instance.SMTPUser = env["SMTPUSER"]
			instance.SMTPass = env["SMTPASS"]
			instance.SMTHost = env["SMTPHOST"]
			instance.SMTPort = port
		}
	})
	return instance
}
