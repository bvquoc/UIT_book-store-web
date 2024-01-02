import { Dialog, DialogTrigger } from "@radix-ui/react-dialog";
import { Button } from "../ui/button";
import { DialogClose, DialogContent, DialogTitle } from "../ui/dialog";
import { Label } from "../ui/label";
import StatusList from "../status-list";

const ChangeStatusDialog = ({
  handleChangeStatus,
  status,
  handleSetStatus,
  disabled,
}: {
  handleChangeStatus: () => void;
  handleSetStatus: (value: boolean) => void;
  status: boolean;
  disabled: boolean;
}) => {
  const displayStatus = {
    trueText: "Đang làm việc",
    falseText: "Đã nghỉ việc",
  };
  return (
    <Dialog>
      <DialogTrigger asChild>
        <Button variant={"outline"} disabled={disabled}>
          Đổi trạng thái
        </Button>
      </DialogTrigger>
      <DialogContent className="p-0 bg-white">
        <DialogTitle className="p-6 pb-0">Đổi trạng thái</DialogTitle>
        <div className="flex flex-col border-y-[1px] p-6 gap-4">
          <Label>Chọn trạng thái muốn chuyển tới</Label>
          <StatusList
            status={status}
            setStatus={handleSetStatus}
            display={displayStatus}
          />
        </div>

        <DialogClose className="ml-auto p-6 pt-0">
          <div className="flex gap-4">
            <Button type="button" variant={"outline"}>
              Thoát
            </Button>

            <Button type="button" onClick={() => handleChangeStatus()}>
              Xác nhận
            </Button>
          </div>
        </DialogClose>
      </DialogContent>
    </Dialog>
  );
};

export default ChangeStatusDialog;