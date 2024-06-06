package server

// ServerBuilder defines the steps required to build a Server
type ServerBuilder interface {
	// SetLogger() ServerBuilder
	SetMiddlewares() ServerBuilder
	SetRoutes() ServerBuilder
	Build() *Server
}
