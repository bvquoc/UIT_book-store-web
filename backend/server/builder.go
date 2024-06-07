package server

// ServerBuilder defines the steps required to build a Server
type ServerBuilder interface {
	SetMiddlewares() ServerBuilder
	SetRoutes() ServerBuilder
	Build() *Server
}
