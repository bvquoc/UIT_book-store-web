package common

import (
	"errors"
	"fmt"
	"net/http"
	"strings"
)

type AppError struct {
	StatusCode int    `json:"statusCode" example:"400"`
	RootErr    error  `json:"-"`
	Message    string `json:"message" example:"error message"`
	Log        string `json:"log" example:"error log"`
	Key        string `json:"errorKey" example:"ErrKey"`
}

func NewErrorResponse(root error, msg, log, key string) *AppError {
	return &AppError{
		StatusCode: http.StatusBadRequest,
		RootErr:    root,
		Message:    msg,
		Log:        log,
		Key:        key,
	}
}

func NewFullErrorResponse(statusCode int, root error, msg, log, key string) *AppError {
	return &AppError{
		StatusCode: statusCode,
		RootErr:    root,
		Message:    msg,
		Log:        log,
		Key:        key,
	}
}

func NewUnauthorized(root error, msg, key string) *AppError {
	return &AppError{
		StatusCode: http.StatusUnauthorized,
		RootErr:    root,
		Message:    msg,
		Key:        key,
	}
}

func NewCustomError(root error, msg, key string) *AppError {
	if root != nil {
		return NewErrorResponse(root, msg, root.Error(), key)
	}

	return NewErrorResponse(errors.New(msg), msg, msg, key)
}

func (e *AppError) RootError() error {
	var err *AppError
	if errors.As(e.RootErr, &err) {
		return err.RootError()
	}
	return e.RootErr
}

func (e *AppError) Error() string {
	return e.RootError().Error()
}

func ErrDB(err error) *AppError {
	return NewErrorResponse(
		err,
		"something went wrong with DB",
		err.Error(),
		"DB_ERROR",
	)
}

func ErrInvalidRequest(err error) *AppError {
	return NewErrorResponse(
		err,
		"invalid request",
		err.Error(),
		"ERROR_INVALID_REQUEST",
	)
}

func ErrInternal(err error) *AppError {
	return NewErrorResponse(
		err,
		"internal error",
		err.Error(),
		"ERROR_INVALID_REQUEST",
	)
}

func ErrCannotListEntity(entity string, err error) *AppError {
	return NewCustomError(
		err,
		fmt.Sprintf("Cannot delete %s", strings.ToLower(entity)),
		fmt.Sprintf("ERR_CANNOT_DELETE_%s", entity),
	)
}

func ErrCannotCreateEntity(entity string, err error) *AppError {
	return NewCustomError(
		err,
		fmt.Sprintf("Cannot create %s", strings.ToLower(entity)),
		fmt.Sprintf("ERR_CANNOT_CREATE_%s", entity),
	)
}

func ErrCannotGetEntity(entity string, err error) *AppError {
	return NewCustomError(
		err,
		fmt.Sprintf("Cannot get %s", strings.ToLower(entity)),
		fmt.Sprintf("ERR_CANNOT_GET_%s", entity),
	)
}

func ErrCannotUpdateEntity(entity string, err error) *AppError {
	return NewCustomError(
		err,
		fmt.Sprintf("Cannot update %s", strings.ToLower(entity)),
		fmt.Sprintf("ERR_CANNOT_UPDATE_%s", entity),
	)
}

func ErrCannotDeleteEntity(entity string, err error) *AppError {
	return NewCustomError(
		err,
		fmt.Sprintf("Cannot delete %s", strings.ToLower(entity)),
		fmt.Sprintf("ERR_CANNOT_DELETE_%s", entity),
	)
}

func ErrEntityDeleted(entity string, err error) *AppError {
	return NewCustomError(
		err,
		fmt.Sprintf("%s deleted", strings.ToLower(entity)),
		fmt.Sprintf("ERR_%s_DELETED", entity),
	)
}

func ErrEntityExisted(entity string, err error) *AppError {
	return NewCustomError(
		err,
		fmt.Sprintf("%s already exists", strings.ToLower(entity)),
		fmt.Sprintf("ERR_%s_ALREADY_EXISTS", entity),
	)
}

func ErrEntityNotFound(entity string, err error) *AppError {
	return NewCustomError(
		err,
		fmt.Sprintf("%s not found", strings.ToLower(entity)),
		fmt.Sprintf("ERR_%s_NOT_FOUND", entity),
	)
}

func ErrNoPermission(err error) *AppError {
	return NewCustomError(
		err,
		fmt.Sprintf("you have no permission"),
		fmt.Sprintf("ERR_NO_PERMISSION"),
	)
}

func ErrIdIsTooLong() *AppError {
	return NewCustomError(
		errIdIsTooLong,
		fmt.Sprintf("maximum length of key is 9"),
		fmt.Sprintf("ERR_ID_IS_TOO_LONG"),
	)
}

func ErrDuplicateKey(err error) *AppError {
	return NewCustomError(
		err,
		fmt.Sprintf("the key has been existed"),
		fmt.Sprintf("ERR_DUPLICATE_KEY"),
	)
}

func ErrRecordNotFound() *AppError {
	return NewCustomError(
		errRecordNotFound,
		fmt.Sprintf(errRecordNotFound.Error()),
		fmt.Sprintf("ERR_RECORD_NOT_FOUND"),
	)
}

var (
	errRecordNotFound = errors.New("record not found")
	errIdIsTooLong    = errors.New("id is too long")
	errDateInvalid    = errors.New("date is not in format dd/mm/yyyy")
)

var ErrDateInvalid = NewCustomError(
	errDateInvalid,
	fmt.Sprintf(errDateInvalid.Error()),
	fmt.Sprintf("ERR_DATE_INVALID"),
)
