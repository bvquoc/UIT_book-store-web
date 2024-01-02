import { endPoint } from "@/constants";
import axios from "axios";
import { getApiKey } from "../auth/action";

export default async function createBook({
  id,
  name,
  bookTitleId,
  edition,
  listedPrice,
  publisherId,
  sellPrice,
}: {
  id?: string;
  name: string;
  bookTitleId: string;
  edition: number;
  listedPrice: number;
  publisherId: string;
  sellPrice: number;
}) {
  const url = `${endPoint}/v1/books`;
  const token = await getApiKey();
  const data = {
    id: id,
    name: name,
    bookTitleId: bookTitleId,
    edition: edition,
    listedPrice: listedPrice,
    publisherId: publisherId,
    sellPrice: sellPrice,
  };
  console.log(data);
  const headers = {
    accept: "application/json",
    "Content-Type": "application/json",
    Authorization: `Bearer ${token}`,
    // Add other headers as needed
  };

  // Make a POST request with headers
  const res = axios
    .post(url, data, { headers: headers })
    .then((response) => {
      if (response) return response.data;
    })
    .catch((error) => {
      console.error("Error:", error);
      return error.response.data;
    });
  return res;
}