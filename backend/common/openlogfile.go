package common

import (
	"fmt"
	"os"
	"path/filepath"
	"time"
)

func OpenLogFile(logDir string) (*os.File, error) {
	// Generate log file name based on the current date
	currentDate := time.Now().Format("2006-01-02")
	logFileName := filepath.Join(logDir, fmt.Sprintf("%s.log", currentDate))

	// Open the log file
	return os.OpenFile(logFileName, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
}
