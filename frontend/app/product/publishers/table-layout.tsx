"use client";

import CreatePublisher from "@/components/book-manage/create-publisher";
import { PublisherTable } from "@/components/book-manage/publisher-table";
import Loading from "@/components/loading";
import { Button } from "@/components/ui/button";
import { endPoint } from "@/constants";
import { useRouter } from "next/navigation";
import { Suspense } from "react";
import { useSWRConfig } from "swr";

const TableLayout = ({
  searchParams,
}: {
  searchParams: { [key: string]: string | string[] | undefined };
}) => {
  const { mutate } = useSWRConfig();

  const router = useRouter();
  const page = searchParams["page"] ?? "1";

  const handlePublisherAdded = (idAuthor: string) => {
    mutate(`${endPoint}/v1/publishers?page=${page ?? 1}&limit=10`);
    router.refresh();
  };
  return (
    <div className="col">
      <div className="flex flex-row justify-between items-center">
        <h1>Nhà xuất bản</h1>
        <div className="flex gap-4">
          <CreatePublisher handlePublisherAdded={handlePublisherAdded}>
            <Button>Thêm nhà xuất bản</Button>
          </CreatePublisher>
        </div>
      </div>
      <div className="flex flex-row flex-wrap gap-2"></div>
      <div className="mb-4 p-3 sha bg-white shadow-[0_1px_3px_0_rgba(0,0,0,0.2)]">
        <Suspense fallback={<Loading />}>
          <PublisherTable searchParams={searchParams} />
        </Suspense>
      </div>
    </div>
  );
};

export default TableLayout;