package middleware

import (
	"book-store-management-backend/common"
	"book-store-management-backend/component/appctx"
	"book-store-management-backend/component/tokenprovider/jwt"
	"book-store-management-backend/module/user/userstore"
	"errors"
	"strings"

	"github.com/gin-gonic/gin"
)

type Requester interface {
	GetUserId() string
	GetEmail() string
	GetName() string
	GetRoleId() string
	IsHasFeature(featureCode string) bool
}

func ErrWrongAuthHeader(err error) *common.AppError {
	return common.NewCustomError(
		err,
		"wrong authen header",
		"ErrWrongAuthHeader",
	)
}

func extractTokenFromHeaderString(s string) (string, error) {
	parts := strings.Split(s, " ")
	//Authorization : Bearer {token}
	if parts[0] != "Bearer" || len(parts) < 2 || strings.TrimSpace(parts[1]) == "" {
		return "", ErrWrongAuthHeader(nil)
	}
	return parts[1], nil
}

func RequireAuth(appCtx appctx.AppContext) func(ctx *gin.Context) {
	tokenProvider := jwt.NewTokenJWTProvider(appCtx.GetSecretKey())
	return func(c *gin.Context) {
		token, err := extractTokenFromHeaderString(c.GetHeader("Authorization"))

		if err != nil {
			panic(err)
		}

		db := appCtx.GetMainDBConnection()

		userStore := userstore.NewSQLStore(db)

		payload, err := tokenProvider.Validate(token)

		if err != nil {
			panic(err)
		}

		user, err := userStore.FindUser(
			c.Request.Context(),
			map[string]interface{}{
				"id": payload.UserId,
			},
			"Role.RoleFeatures",
		)

		if err != nil {
			//c.AbortWithStatusJSON(http.StatusUnauthorized, err)
			panic(err)
		}

		if !user.IsActive {
			panic(common.ErrNoPermission(errors.New("user has been deleted or banned")))
		}

		c.Set(common.CurrentUserStr, user)
		c.Next()
	}

}
