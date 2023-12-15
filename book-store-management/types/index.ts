import { IconType } from "react-icons";

export type Book = {
  id: string;
  name: string;
  publisherId: string;

  quantity: number;
  listedPrice: number;
  sellPrice: number;

  isActive: boolean;
  categoryIds: [];

  authorIds: [];
  desc: string;
  edition: number;
};
export type ImportNote = {
  id: string;
  supplier: {
    id: string;
    name: string;
  };
  totalPrice: number;
  status: StatusNote;
  createdBy: {
    id: string;
    name: string;
  };
  closedBy?: {
    id: string;
    name: string;
  };
  createdAt: Date;
  closedAt?: Date;
};

export type ImportDetail = {
  book: Book;
  idNote: string;
  quantity: number;
  price: number;
};

export type Supplier = {
  id: string;
  name: string;
  email?: string;
  phone: string;
  debt: number;
};
export type SupplierDebt = {
  createdAt: Date;
  createdBy: {
    id: string;
    name: string;
  };
  id: string;
  qty: number;
  qtyLeft: number;
  supplierId: string;
  type: string;
};

export enum StatusNote {
  Inprogress = "InProgress",
  Done = "Done",
  Cancel = "Cancel",
}
export enum StatusActive {
  Active = "Đang giao dịch",
  InActive = "Ngừng giao dịch",
}
export type Category = {
  id: string;
  name: string;
};

export type Author = {
  id: string;
  name: string;
};
export type Publisher = {
  id: string;
  name: string;
};

export type Staff = {
  address?: string;
  email: string;
  id: string;
  isActive: boolean;
  name: string;
  phone?: string;
  role: {
    id: string;
    name: string;
  };
};
export type Role = {
  id: string;
  name: string;
};
export type RoleFunction = {
  id: string;
  description: string;
};
export interface CategoryListProps {
  checkedCategory: Array<string>;
  onCheckChanged: (idCate: string) => void;
  canAdd?: boolean;
  readonly?: boolean;
}
export interface AuthorListProps {
  checkedAuthor: Array<string>;
  onCheckChanged: (idAuthor: string) => void;
  canAdd?: boolean;
  readonly?: boolean;
}
export interface SupplierListProps {
  supplier: string;
  setSupplier: (supplier: string) => void;
  canAdd?: boolean;
}
export interface BookListProps {
  book: Partial<Book>;
  setBook: (book: Partial<Book>) => void;
  isNew: boolean;
  setIsNew: (isNew: boolean) => void;
}

export type SidebarItem = {
  title: string;
  href: string;
  icon?: IconType;
  submenu?: boolean;
  subMenuItems?: SidebarItem[];
};
export interface RoleListProps {
  role: string;
  setRole: (role: string) => void;
}

export type PagingProps = {
  page: number;
  limit: number;
  total: number;
};
