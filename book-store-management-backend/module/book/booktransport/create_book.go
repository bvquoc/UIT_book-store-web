package booktransport

import (
	"book-store-management-backend/component/appctx"
	"github.com/gin-gonic/gin"
)

// @BasePath /v1
// @Security BearerAuth
// @Summary Create book name, desc, authors, categories, publisher, .etc
// @Tags books
// @Accept json
// @Produce json
// @Param book body bookmodel.ReqCreateBook true "Create book"
// @Response 200 {object} bookmodel.ResCreateBook "book id"
// @Router /books [post]
func CreateBook(appCtx appctx.AppContext) gin.HandlerFunc {
	return func(c *gin.Context) {
		//var data bookmodel.ReqCreateBook
		////c.JSON(http.StatusOK, common.SimpleSuccessResponse(data))
		//
		//if err := c.ShouldBind(&data); err != nil {
		//	panic(common.ErrInvalidRequest(err))
		//}
		//
		//requester := c.MustGet(common.CurrentUserStr).(middleware.Requester)
		//
		//db := appCtx.GetMainDBConnection().Begin()
		//
		//store := bookstore.NewSQLStore(db)
		//repo := bookrepo.NewCreateBookRepo(store)
		//
		//gen := generator.NewShortIdGenerator()
		//
		//business := bookbiz.NewCreateBookBiz(gen, repo, requester)
		//
		//fmt.Print(data)
		//if err := business.CreateBook(c.Request.Context(), &data); err != nil {
		//	db.Rollback()
		//	panic(err)
		//}
		//
		//if err := db.Commit().Error; err != nil {
		//	db.Rollback()
		//	panic(err)
		//}
		//
		//c.JSON(http.StatusOK, common.SimpleSuccessResponse(data.ID))
	}
}
