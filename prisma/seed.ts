import { PrismaClient, Prisma } from "@prisma/client";
import { v4 as uuidv4 } from "uuid";
const prisma = new PrismaClient();
import _ from "lodash";

async function main() {
  await prisma.subsectionCourseAssetRelation.deleteMany();
  await prisma.coursePartRelation.deleteMany();
  await prisma.courseMasterRecordRelation.deleteMany();
  await prisma.sectionSubsectionRelation.deleteMany();
  await prisma.partSectionRelation.deleteMany();
  await prisma.courseBin.deleteMany();
  await prisma.courseAssetRevision.deleteMany();
  await prisma.courseAsset.deleteMany();
  await prisma.subsectionRevision.deleteMany();
  await prisma.subsection.deleteMany();
  await prisma.sectionRevision.deleteMany();
  await prisma.section.deleteMany();
  await prisma.partRevision.deleteMany();
  await prisma.part.deleteMany();
  await prisma.courseRevision.deleteMany();
  await prisma.course.deleteMany();

  const courseAmount = 2;
  const courseRevision = 5;

  const partAmount = 2;
  const partRevision = 5;

  const sectionAmount = 2;
  const sectionRevision = 2;

  const subsectionAmount = 1;
  const subsectionRevision = 2;

  const courseAssetAmount = 4;
  const courseAssetRevision = 2;

  const masterRecordAmount = 2;
  const masterRecordRevision = 2;

  for (let i = 0; i < courseAmount; i++) {
    const courseId = uuidv4();

    await prisma.course.create({
      data: {
        id: courseId,
        version: "V01",
      },
    });

    await prisma.courseRevision.createMany({
      data: _.range(courseRevision).map((i) => ({
        courseId: courseId,
        internalNote: "internalNote-" + i,
        revision: i + 1,
        itemsRevision: i + 1,
        metaRevision: i + 1,
      })),
    });

    await prisma.courseBin.create({
      data: {
        id: uuidv4(),
        courseId: courseId,
        assets: {},
      },
    });

    for (let m = 0; m < masterRecordAmount; m++) {
      const masterRecordId = uuidv4();
      await prisma.courseMasterRecord.create({
        data: {
          id: masterRecordId,
          //in real scenario, this is a shared master record to many courses
          masterRecordId: uuidv4(),
          masterRecordRevision: 1,
          values: {},
        },
      });

      await prisma.courseMasterRecordRelation.createMany({
        data: _.range(courseRevision).map((i) => ({
          courseId: courseId,
          courseRevision: i + 1,
          courseMetaRevision: i + 1,
          masterRecordId: masterRecordId,
        })),
      });
    }

    for (let j = 0; j < partAmount; j++) {
      const partId = uuidv4();
      await prisma.part.create({
        data: {
          id: partId,
        },
      });

      await prisma.partRevision.createMany({
        data: _.range(partRevision).map((i) => ({
          partId: partId,
          title: `${partId}-part_title-${i}`,
          revision: i + 1,
          itemsRevision: i + 1,
        })),
      });

      await prisma.coursePartRelation.createMany({
        data: _.range(courseRevision).map((i) => ({
          courseId: courseId,
          partId: partId,
          courseItemsRevision: i + 1,
          courseRevision: i + 1,
          partRevision: partRevision,
        })),
      });

      for (let p = 0; p < sectionAmount; p++) {
        const sectionId = uuidv4();

        await prisma.section.create({
          data: {
            id: sectionId,
          },
        });

        await prisma.sectionRevision.createMany({
          data: _.range(sectionRevision).map((i) => ({
            sectionId: sectionId,
            itemsRevision: i + 1,
            revision: i + 1,
            title: `${sectionId}-section_title-${i}`,
          })),
        });

        await prisma.partSectionRelation.createMany({
          data: _.range(partRevision).map((i) => ({
            partId: partId,
            sectionId: sectionId,
            partItemsRevision: i + 1,
            partRevision: i + 1,
            sectionRevision: sectionRevision,
          })),
        });

        for (let q = 0; q < subsectionAmount; q++) {
          const subsectionId = uuidv4();

          await prisma.subsection.create({
            data: {
              id: subsectionId,
            },
          });

          await prisma.subsectionRevision.createMany({
            data: _.range(subsectionRevision).map((i) => ({
              subsectionId: subsectionId,
              itemsRevision: i + 1,
              revision: i + 1,
              title: `${subsectionId}-subsection_title-${i}`,
            })),
          });

          await prisma.sectionSubsectionRelation.createMany({
            data: _.range(sectionRevision).map((i) => ({
              sectionId: sectionId,
              subsectionId: subsectionId,
              sectionItemsRevision: i + 1,
              sectionRevision: i + 1,
              subsectionRevision: subsectionRevision,
            })),
          });

          for (let r = 0; r < courseAssetAmount; r++) {
            const courseAssetId = uuidv4();

            await prisma.courseAsset.create({
              data: {
                id: courseAssetId,
                assetId: uuidv4(),
                assetType: "VIDEO",
                assetRevision: 1,
              },
            });

            await prisma.courseAssetRevision.createMany({
              data: _.range(courseAssetRevision).map((i) => ({
                courseAssetId: courseAssetId,
                revision: i + 1,
                displayName: `${courseAssetId}-courseAsset_displayName-${i}`,
                other: `${courseAssetId}-courseAsset_other-${i}`,
                timestamp: "mock-timestamp",
              })),
            });

            await prisma.subsectionCourseAssetRelation.createMany({
              data: _.range(subsectionRevision).map((i) => ({
                subsectionId: subsectionId,
                courseAssetId: courseAssetId,
                subsectionItemsRevision: i + 1,
                subsectionRevision: i + 1,
                courseAssetRevision: courseAssetRevision,
              })),
            });
          }
        }
      }
    }
  }
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
