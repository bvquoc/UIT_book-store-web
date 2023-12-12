package booktitletransport

import (
	"book-store-management-backend/common"
	"book-store-management-backend/component/appctx"
	"book-store-management-backend/middleware"
	"book-store-management-backend/module/author/authorrepo"
	"book-store-management-backend/module/author/authorstore"
	"book-store-management-backend/module/booktitle/booktitlebiz"
	"book-store-management-backend/module/booktitle/booktitlemodel"
	"book-store-management-backend/module/booktitle/booktitlerepo"
	"book-store-management-backend/module/booktitle/booktitlestore"
	"book-store-management-backend/module/category/categoryrepo"
	"book-store-management-backend/module/category/categorystore"
	"book-store-management-backend/module/publisher/publisherrepo"
	"book-store-management-backend/module/publisher/publisherstore"
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
)

func UpdateBookTitleInfo(appCtx appctx.AppContext) gin.HandlerFunc {
	return func(c *gin.Context) {
		id := c.Param("id")
		var reqData booktitlemodel.ReqUpdateBookInfo

		if err := c.ShouldBind(&reqData); err != nil || id == "" {
			panic(common.ErrInvalidRequest(err))
		}

		reqData.Id = &id

		fmt.Println(reqData)

		requester := c.MustGet(common.CurrentUserStr).(middleware.Requester)

		db := appCtx.GetMainDBConnection().Begin()
		store := booktitlestore.NewSQLStore(db)
		authorStore := authorstore.NewSQLStore(db)
		publisherStore := publisherstore.NewSQLStore(db)
		categoryStore := categorystore.NewSQLStore(db)

		repo := booktitlerepo.NewUpdateBookRepo(store)
		authorRepo := authorrepo.NewExistAuthorRepo(authorStore)
		publisherRepo := publisherrepo.NewExistPublisherRepo(publisherStore)
		categoryRepo := categoryrepo.NewExistCategoryRepo(categoryStore)

		biz := booktitlebiz.NewUpdateBookBiz(repo, authorRepo, publisherRepo, categoryRepo, requester)

		err := biz.UpdateBookTitle(c.Request.Context(), id, &reqData)
		if err != nil {
			panic(err)
		}

		if err := db.Commit().Error; err != nil {
			db.Rollback()
			panic(err)
		}
		c.JSON(http.StatusOK, common.SimpleSuccessResponse(true))
	}
}