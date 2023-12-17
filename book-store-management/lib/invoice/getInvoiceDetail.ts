import { apiKey } from "@/constants";

export default async function getInvoiceDetail({
  idInvoice,
}: {
  idInvoice: string;
}) {
  const res = await fetch(`http://localhost:8080/v1/invoices/${idInvoice}`, {
    headers: {
      accept: "application/json",
      Authorization: apiKey,
    },
    next: {
      revalidate: 0,
    },
  });
  if (!res.ok) {
    // throw new Error("Failed to fetch data");
    return res.json();
  }
  return res.json().then((json) => json.data);
}
