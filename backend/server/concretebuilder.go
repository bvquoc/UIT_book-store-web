package server

import (
	"log"

	"book-store-management-backend/common"
	"book-store-management-backend/component/appctx"
	"book-store-management-backend/middleware"
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

type ConcreteServerBuilder struct {
	router *gin.Engine
	appCtx appctx.AppContext
}

func NewServerBuilder(appCtx appctx.AppContext) *ConcreteServerBuilder {
	logFile, err := common.OpenLogFile(appCtx.GetLogDir())
	if err != nil {
		log.Fatalf("Failed to open log file: %v", err)
	}
	gin.DefaultWriter = logFile
	gin.DefaultErrorWriter = logFile
	router := gin.New()
	router.Use(gin.LoggerWithConfig(gin.LoggerConfig{
		Output: gin.DefaultWriter, // Direct log output to file
	}))
	return &ConcreteServerBuilder{
		router: router,
		appCtx: appCtx,
	}
}

func (b *ConcreteServerBuilder) SetMiddlewares() ServerBuilder {
	b.router.Use(middleware.CORSMiddleware())
	b.router.Use(middleware.Recover(b.appCtx))
	return b
}

func (b *ConcreteServerBuilder) SetReleaseMode() ServerBuilder {
	gin.SetMode(gin.ReleaseMode)
	return b
}

func (b *ConcreteServerBuilder) SetRoutes() ServerBuilder {
	docs.SwaggerInfo.BasePath = "/v1"
	v1 := b.router.Group("/v1")
	{
		v1.GET("/docs/*any", ginSwagger.WrapHandler(swaggerfiles.Handler))
		uploadtransport.SetupRoutes(v1, b.appCtx)

		authortransport.SetupRoutes(v1, b.appCtx)
		categorytransport.SetupRoutes(v1, b.appCtx)
		booktitletransport.SetupRoutes(v1, b.appCtx)
		booktransport.SetupRoutes(v1, b.appCtx)
		publishertransport.SetupRoutes(v1, b.appCtx)
		gininvoice.SetupRoutes(v1, b.appCtx)
		ginimportnote.SetupRoutes(v1, b.appCtx)
		gininventorychecknote.SetupRoutes(v1, b.appCtx)
		ginsupplier.SetupRoutes(v1, b.appCtx)
		gincustomer.SetupRoutes(v1, b.appCtx)
		ginrole.SetupRoutes(v1, b.appCtx)
		ginfeature.SetupRoutes(v1, b.appCtx)
		ginuser.SetupRoutes(v1, b.appCtx)
		ginshopgeneral.SetupRoutes(v1, b.appCtx)
		gindashboard.SetupRoutes(v1, b.appCtx)
		report := v1.Group("/reports")
		{
			ginstockreports.SetupRoutes(report, b.appCtx)
			ginsupplierdebtreport.SetupRoutes(report, b.appCtx)
			ginsalereport.SetupRoutes(report, b.appCtx)
		}
	}
	return b
}

func (b *ConcreteServerBuilder) Build() *Server {
	return &Server{
		router: b.router,
		appCtx: b.appCtx,
	}
}
