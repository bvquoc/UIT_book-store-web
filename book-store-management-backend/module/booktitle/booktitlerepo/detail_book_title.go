package booktitlerepo

import (
	"book-store-management-backend/module/booktitle/booktitlemodel"
	"book-store-management-backend/module/booktitle/booktitlestore"
	"context"
	"strings"
)

type DetailBookTitleStore interface {
	DetailBookTitle(ctx context.Context, id string) (*booktitlestore.BookTitleDBModel, error)
}

type detailBookTitleRepo struct {
	store DetailBookTitleStore
}

func NewDetailBookTitleRepo(store DetailBookTitleStore) *detailBookTitleRepo {
	return &detailBookTitleRepo{store: store}
}

func (repo *detailBookTitleRepo) DetailBookTitle(ctx context.Context, id string) (*booktitlemodel.BookTitle, error) {
	rawResult, err := repo.store.DetailBookTitle(ctx, id)
	if err != nil {
		return nil, err
	}

	result := booktitlemodel.BookTitle{
		ID:          rawResult.ID,
		Name:        *rawResult.Name,
		Description: *rawResult.Description,
		AuthorIDs:   strings.Split(*rawResult.AuthorIDs, "|"),
		CategoryIDs: strings.Split(*rawResult.CategoryIDs, "|"),
		CreatedAt:   rawResult.CreatedAt,
		UpdatedAt:   rawResult.UpdatedAt,
		DeletedAt:   rawResult.DeletedAt,
		IsActive:    rawResult.IsActive,
	}
	return &result, nil
}