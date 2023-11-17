package ginuser

import (
	"book-store-management-backend/common"
	"book-store-management-backend/component/appctx"
	"book-store-management-backend/component/hasher"
	"book-store-management-backend/component/tokenprovider/jwt"
	"book-store-management-backend/module/user/userbiz"
	"book-store-management-backend/module/user/usermodel"
	"book-store-management-backend/module/user/userrepo"
	"book-store-management-backend/module/user/userstore"
	"github.com/gin-gonic/gin"
	"net/http"
)

func Login(appCtx appctx.AppContext) gin.HandlerFunc {
	return func(c *gin.Context) {
		var data usermodel.UserLogin

		if err := c.ShouldBind(&data); err != nil {
			c.JSON(http.StatusBadRequest, common.ErrInvalidRequest(err))
		}

		db := appCtx.GetMainDBConnection().Begin()

		tokenProvider := jwt.NewTokenJWTProvider(appCtx.GetSecretKey())

		store := userstore.NewSQLStore(db)
		repo := userrepo.NewLoginRepo(store)

		md5 := hasher.NewMd5Hash()

		business := userbiz.NewLoginBiz(appCtx, repo, 60*60*24*30, tokenProvider, md5)
		account, err := business.Login(c.Request.Context(), &data)

		if err != nil {
			panic(err)
		}

		c.JSON(http.StatusOK, common.SimpleSuccessResponse(account))
	}
}
