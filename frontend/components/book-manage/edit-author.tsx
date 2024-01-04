"use client";
import { SubmitHandler, useForm } from "react-hook-form";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { zodResolver } from "@hookform/resolvers/zod";
import * as z from "zod";
import { useState } from "react";
import { toast } from "@/components/ui/use-toast";
import updateAuthor from "@/lib/book/updateAuthor";
import { Author } from "@/types";
const required = z.string().min(1, "Không để trống trường này");

const SupplierSchema = z.object({
  name: required,
});

const EditAuthor = ({
  author,
  handleAuthorEdited,
  children,
}: {
  author: Author;
  handleAuthorEdited: (name: string) => void;
  children: React.ReactNode;
}) => {
  const {
    register,
    handleSubmit,
    reset,
    formState: { errors, isDirty },
  } = useForm<z.infer<typeof SupplierSchema>>({
    resolver: zodResolver(SupplierSchema),
  });
  const onSubmit: SubmitHandler<z.infer<typeof SupplierSchema>> = async (
    data
  ) => {
    setOpen(false);

    const response: Promise<any> = updateAuthor({
      idAuthor: author.id,
      name: data.name,
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
        description: "Chỉnh sửa tác giả thành công",
      });
      handleAuthorEdited(responseData.name);
      setOpen(false);
    }
  };

  const [open, setOpen] = useState(false);
  return (
    <Dialog
      open={open}
      onOpenChange={(open) => {
        reset({ name: author.name });
        setOpen(open);
      }}
    >
      <DialogTrigger asChild>{children}</DialogTrigger>
      <DialogContent className="max-w-[472px] p-0 bg-white">
        <DialogHeader>
          <DialogTitle className="p-6 pb-0">Chỉnh sửa tác giả</DialogTitle>
        </DialogHeader>
        <form>
          <div className="p-6 flex flex-col gap-4 border-y-[1px]">
            <div>
              <Label htmlFor="nameNcc">Tên tác giả</Label>
              <Input id="nameNcc" {...register("name")}></Input>
              {errors.name && (
                <span className="error___message">{errors.name.message}</span>
              )}
            </div>
          </div>
          <div className="p-4 flex-1 flex justify-end">
            <div className="flex gap-4">
              <Button
                type="reset"
                variant={"outline"}
                onClick={() => setOpen(false)}
              >
                Huỷ
              </Button>

              <Button
                disabled={!isDirty}
                type="button"
                onClick={handleSubmit(onSubmit)}
              >
                Lưu
              </Button>
            </div>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  );
};

export default EditAuthor;
