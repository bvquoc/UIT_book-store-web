"use client";

import BookInsert from "@/components/stock-manage/book-insert";
import { Card, CardContent } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { SubmitErrorHandler, SubmitHandler, useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { endPoint, required } from "@/constants";
import { Button } from "@/components/ui/button";
import { LuCheck } from "react-icons/lu";
import { FiTrash2 } from "react-icons/fi";
import SupplierList from "@/components/supplier-list";
import { useState } from "react";
import { toast } from "@/components/ui/use-toast";
import createImportNote from "@/lib/import/createImportNote";
import { Switch } from "@/components/ui/switch";
import { useSWRConfig } from "swr";
import Loading from "@/components/loading";
import { getApiKey } from "@/lib/auth/action";
import getAllBookList from "@/lib/book/getAllBookList";

export const FormSchema = z.object({
  id: z.string().max(12, "Tối đa 12 ký tự"),
  supplierId: required,
  details: z
    .array(
      z.object({
        bookId: z.string(),
        isReplacePrice: z.boolean(),
        price: z.coerce.number().gte(1, "Đơn giá phải lớn hơn 0"),
        oldPrice: z.coerce.number(),
        qtyImport: z.coerce.number().gte(1, "Số lượng phải lớn hơn 0"),
      })
    )
    .nonempty("Vui lòng chọn ít nhất một sách nhập"),
});

const AddNote = () => {
  const [supplierId, setSupplierId] = useState("");
  const [openDialog, setOpenDialog] = useState(false);
  const [isReplacePrice, setIsReplacePrice] = useState<boolean>(false);
  const { mutate } = useSWRConfig();

  const handleSupplierIdSet = (idSupplier: string) => {
    setSupplierId(idSupplier);
    setValue("supplierId", idSupplier, { shouldDirty: true });
    trigger("supplierId");
  };
  const form = useForm<z.infer<typeof FormSchema>>({
    resolver: zodResolver(FormSchema),
    defaultValues: {
      id: "",
      supplierId: "",
      details: [],
    },
  });
  const {
    register,
    handleSubmit,
    setValue,
    trigger,
    watch,
    reset,
    formState: { errors, isDirty },
  } = form;
  const onSubmit: SubmitHandler<z.infer<typeof FormSchema>> = async (data) => {
    console.log(data);
    const response: Promise<any> = createImportNote({
      details: data.details.map((item) => {
        return {
          bookId: item?.bookId,
          qtyImport: item?.qtyImport,
          price: item?.price,
          isReplacePrice: isReplacePrice,
        };
      }),
      id: data.id,
      supplierId: data.supplierId,
    });
    const responseData = await response;
    if (responseData.hasOwnProperty("errorKey")) {
      toast({
        variant: "destructive",
        title: "Có lỗi",
        description: responseData.message,
      });
    } else {
      toast({
        variant: "success",
        title: "Thành công",
        description: "Thêm phiếu nhập thành công",
      });
      reset();
      setSupplierId("");
      if (isReplacePrice) {
        mutate(`${endPoint}/books/all`);
        setIsReplacePrice(false);
      }
    }
  };
  const onError: SubmitErrorHandler<z.infer<typeof FormSchema>> = (data) => {
    console.log(data);
    if (data.hasOwnProperty("details")) {
      toast({
        variant: "destructive",
        title: "Có lỗi",
        description: data.details?.message,
      });
    }
  };

  return (
    <div className="col items-center">
      <div className="col xl:w-4/5 w-full xl:px-0 md:px-6 px-0">
        <div className="flex justify-between gap-2">
          <h1 className="font-medium text-xxl self-start">Thêm phiếu nhập</h1>
        </div>

        <form onSubmit={handleSubmit(onSubmit, onError)}>
          <div className="flex flex-col gap-4">
            <div className="flex lg:flex-row flex-col gap-4">
              <Card className="basis-3/4">
                <CardContent className="lg:p-6 p-4 flex lg:flex-row flex-col gap-4">
                  <div className="flex-1">
                    <Label>Mã phiếu</Label>
                    <Input
                      placeholder="Mã sinh tự động nếu để trống"
                      {...register("id")}
                    ></Input>
                    {errors.id && (
                      <span className="error___message">
                        {errors.id.message}
                      </span>
                    )}
                  </div>
                  <div className="flex-1">
                    <Label>Nhà cung cấp</Label>
                    <SupplierList
                      supplierId={supplierId}
                      setSupplierId={handleSupplierIdSet}
                    />
                    {errors.supplierId && (
                      <span className="error___message">
                        {errors.supplierId.message}
                      </span>
                    )}
                  </div>
                </CardContent>
              </Card>
              <Card className="basis-1/4">
                <CardContent className="lg:p-6 p-4 flex justify-between gap-4">
                  <span className="w-2/3 text-sm font-medium">
                    Cập nhật giá mới khi thêm
                  </span>
                  <Switch
                    checked={isReplacePrice}
                    onCheckedChange={setIsReplacePrice}
                  />
                </CardContent>
              </Card>
            </div>
            <Card>
              <CardContent className="lg:p-6 p-4">
                <BookInsert form={form} />
              </CardContent>
            </Card>
            <div className="flex md:justify-end justify-stretch gap-2">
              <Button
                className="px-4 bg-white md:flex-none flex-1"
                disabled={!isDirty}
                variant={"outline"}
                type="button"
                onClick={() => {
                  reset({
                    id: "",
                    supplierId: "",
                    details: [],
                  });
                  setSupplierId("");
                }}
              >
                <div className="flex flex-wrap gap-2 items-center">
                  <FiTrash2 className="text-muted-foreground" />
                  Hủy
                </div>
              </Button>
              <Button className="px-4 pl-2 md:flex-none  flex-1">
                <div className="flex flex-wrap gap-2 items-center">
                  <LuCheck />
                  Thêm
                </div>
              </Button>
            </div>
          </div>
        </form>
      </div>
    </div>
  );
};

export default AddNote;
