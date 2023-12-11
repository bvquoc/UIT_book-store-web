package booktransport

import (
	"book-store-management-backend/common"
	"book-store-management-backend/component/appctx"
	"book-store-management-backend/middleware"
	"book-store-management-backend/module/author/authorrepo"
	"book-store-management-backend/module/author/authorstore"
	"book-store-management-backend/module/book/bookbiz"
	"book-store-management-backend/module/book/bookmodel"
	"book-store-management-backend/module/book/bookrepo"
	"book-store-management-backend/module/book/bookstore"
	"book-store-management-backend/module/category/categoryrepo"
	"book-store-management-backend/module/category/categorystore"
	"book-store-management-backend/module/publisher/publisherrepo"
	"book-store-management-backend/module/publisher/publisherstore"
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
)

func UpdateBookInfo(appCtx appctx.AppContext) gin.HandlerFunc {
	return func(c *gin.Context) {
		id := c.Param("id")
		fmt.Println(id)
		var reqData bookmodel.ReqUpdateBookInfo

		if err := c.ShouldBind(&reqData); err != nil || id == "" {
			panic(common.ErrInvalidRequest(err))
		}

		reqData.Id = &id

		fmt.Println(reqData)

		requester := c.MustGet(common.CurrentUserStr).(middleware.Requester)

		db := appCtx.GetMainDBConnection()
		store := bookstore.NewSQLStore(db)
		authorStore := authorstore.NewSQLStore(db)
		publisherStore := publisherstore.NewSQLStore(db)
		categoryStore := categorystore.NewSQLStore(db)

		repo := bookrepo.NewUpdateBookRepo(store)
		authorRepo := authorrepo.NewExistAuthorRepo(authorStore)
		publisherRepo := publisherrepo.NewExistPublisherRepo(publisherStore)
		categoryRepo := categoryrepo.NewExistCategoryRepo(categoryStore)

		biz := bookbiz.NewUpdateBookBiz(repo, authorRepo, publisherRepo, categoryRepo, requester)

		err := biz.UpdateBook(c.Request.Context(), id, &reqData)
		if err != nil {
			panic(err)
		}

		c.JSON(http.StatusOK, common.SimpleSuccessResponse(true))
	}
}
