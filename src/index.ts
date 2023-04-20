import { PrismaClient } from "@prisma/client";
import { writeFile } from "fs";

const prisma = new PrismaClient();

async function main() {
  const startTime = performance.now();

  const result = await prisma.course.findUnique({
    where: {
      id: "a5745940-52ce-41f2-b265-6af06751b432",
    },
    include: {
      courseBin: true,
      courseRevisions: {
        orderBy: {
          revision: "desc",
        },
        take: 1,
        include: {
          courseMasterRecords: {
            include: {
              masterRecord: true,
            },
          },
          parts: {
            include: {
              part: {
                include: {
                  sections: {
                    include: {
                      section: {
                        include: {
                          subsections: {
                            include: {
                              subsection: {
                                include: {
                                  courseAssets: {
                                    include: {
                                      asset: true,
                                    },
                                  },
                                },
                              },
                            },
                          },
                        },
                      },
                    },
                  },
                },
              },
            },
          },
        },
      },
    },
  });

  const endTime = performance.now();

  writeFile("result.json", JSON.stringify(result), (err) => {
    console.log(err);
    process.exit(1);
  });
  console.log("Execute time: " + (endTime - startTime) + "ms");
}

main();
