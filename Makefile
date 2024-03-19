postgres:
	docker run --name xyfin -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14-alpine


createdb:
	docker exec -it xyfin createdb --username=root --owner=root xyfin

dropdb:
	docker exec -it xyfin dropdb xyfin

migrateup:
	migrate -path database/migrations -database "postgresql://root:secret@localhost:5432/xyfin?sslmode=disable" -verbose up

migratedown:
	migrate -path database/migrations -database "postgresql://root:secret@localhost:5432/xyfin?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test