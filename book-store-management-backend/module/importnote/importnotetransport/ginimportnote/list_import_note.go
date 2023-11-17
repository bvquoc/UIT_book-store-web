package ginimportnote

import (
	"book-store-management-backend/common"
	"book-store-management-backend/component/appctx"
	"book-store-management-backend/middleware"
	"book-store-management-backend/module/importnote/importnotebiz"
	"book-store-management-backend/module/importnote/importnotemodel"
	"book-store-management-backend/module/importnote/importnoterepo"
	"book-store-management-backend/module/importnote/importnotestore"
	"github.com/gin-gonic/gin"
	"net/http"
)

func ListImportNote(appCtx appctx.AppContext) gin.HandlerFunc {
	return func(c *gin.Context) {
		var filter importnotemodel.Filter
		if err := c.ShouldBind(&filter); err != nil {
			panic(common.ErrInvalidRequest(err))
		}

		var paging common.Paging
		if err := c.ShouldBind(&paging); err != nil {
			panic(common.ErrInvalidRequest(err))
		}

		paging.Fulfill()

		store := importnotestore.NewSQLStore(appCtx.GetMainDBConnection())
		repo := importnoterepo.NewListImportNoteRepo(store)

		requester := c.MustGet(common.CurrentUserStr).(middleware.Requester)

		biz := importnotebiz.NewListImportNoteBiz(repo, requester)

		result, err := biz.ListImportNote(c.Request.Context(), &filter, &paging)

		if err != nil {
			panic(err)
		}

		c.JSON(http.StatusOK, common.NewSuccessResponse(result, paging, filter))
	}
}
