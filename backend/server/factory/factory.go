package serverfactory

import (
	"book-store-management-backend/component/appctx"
	"book-store-management-backend/module/author/authortransport"
	"book-store-management-backend/module/book/booktransport"
	"book-store-management-backend/module/booktitle/booktitletransport"
	"book-store-management-backend/module/category/categorytransport"
	"book-store-management-backend/module/customer/customertransport/gincustomer"
	"book-store-management-backend/module/dashboard/dashboardtransport/gindashboard"
	"book-store-management-backend/module/feature/featuretransport/ginfeature"
	"book-store-management-backend/module/importnote/importnotetransport/ginimportnote"
	"book-store-management-backend/module/inventorychecknote/inventorychecknotetransport/gininventorychecknote"
	"book-store-management-backend/module/invoice/invoicetransport/gininvoice"
	"book-store-management-backend/module/publisher/publishertransport"
	"book-store-management-backend/module/role/roletransport/ginrole"
	"book-store-management-backend/module/salereport/salereporttransport/ginsalereport"
	"book-store-management-backend/module/shopgeneral/shopgeneraltransport/ginshopgeneral"
	ginstockreports "book-store-management-backend/module/stockreport/stockreporttransport/ginstockreport"
	"book-store-management-backend/module/supplier/suppliertransport/ginsupplier"
	"book-store-management-backend/module/supplierdebtreport/supplierdebtreporttransport/ginsupplierdebtreport"
	"book-store-management-backend/module/upload/uploadtransport"
	"book-store-management-backend/module/user/usertransport/ginuser"

	"book-store-management-backend/docs"

	"github.com/gin-gonic/gin"
	swaggerfiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
)

func SetupModuleRoutes(r *gin.Engine, appCtx appctx.AppContext) {

	docs.SwaggerInfo.BasePath = "/v1"
	v1 := r.Group("/v1")
	{
		v1.GET("/docs/*any", ginSwagger.WrapHandler(swaggerfiles.Handler))
		uploadtransport.SetupRoutes(v1, appCtx)

		authortransport.SetupRoutes(v1, appCtx)
		categorytransport.SetupRoutes(v1, appCtx)
		booktitletransport.SetupRoutes(v1, appCtx)
		booktransport.SetupRoutes(v1, appCtx)
		publishertransport.SetupRoutes(v1, appCtx)
		gininvoice.SetupRoutes(v1, appCtx)
		ginimportnote.SetupRoutes(v1, appCtx)
		gininventorychecknote.SetupRoutes(v1, appCtx)
		ginsupplier.SetupRoutes(v1, appCtx)
		gincustomer.SetupRoutes(v1, appCtx)
		ginrole.SetupRoutes(v1, appCtx)
		ginfeature.SetupRoutes(v1, appCtx)
		ginuser.SetupRoutes(v1, appCtx)
		ginshopgeneral.SetupRoutes(v1, appCtx)
		gindashboard.SetupRoutes(v1, appCtx)
		report := v1.Group("/reports")
		{
			ginstockreports.SetupRoutes(report, appCtx)
			ginsupplierdebtreport.SetupRoutes(report, appCtx)
			ginsalereport.SetupRoutes(report, appCtx)
		}
	}
}
