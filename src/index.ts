import { Prisma, PrismaClient } from "@prisma/client";
import { writeFile } from "fs";
import { orderBy } from "lodash";

const prisma = new PrismaClient();

async function main() {
  const startTime = performance.now();
  // const result = await prisma.course.findUnique({
  //   where: {
  //     id: "06b10cea-36b8-4924-8de3-dea7afd8bfff",
  //   },
  //   include: {
  //     courseVersioneds: {
  //       orderBy: {
  //         revision: "desc",
  //       },
  //       take: 1,
  //       include: {
  //         courseMasterRecords: {
  //           orderBy: {
  //             revision: "desc",
  //           },
  //           include: {
  //             masterRecord: true,
  //           },
  //         },
  //         parts: {
  //           orderBy: {
  //             revision: "desc",
  //           },
  //           include: {
  //             part: {
  //               include: {
  //                 sections: {
  //                   include: {
  //                     section: {
  //                       include: {
  //                         subsections: {
  //                           include: {
  //                             subsection: {
  //                               include: {
  //                                 courseAssets: true,
  //                               },
  //                             },
  //                           },
  //                         },
  //                       },
  //                     },
  //                   },
  //                 },
  //               },
  //             },
  //           },
  //         },
  //       },
  //     },
  //   },
  // });

  const result = prisma.course.findUnique({
    where: {
      id: "1e12b0e0-c2cc-4198-ba57-66ccd7052022",
    },
  });

  console.log(result);

  const endTime = performance.now();

  writeFile("result.json", JSON.stringify(result), (err) => {
    console.log(err);
    process.exit(1);
  });
  console.log("Execute time: " + (endTime - startTime) + "ms");
}

main();
