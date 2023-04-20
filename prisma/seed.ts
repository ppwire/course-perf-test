import { PrismaClient, Prisma } from "@prisma/client";
import { v4 as uuidv4 } from "uuid";
const prisma = new PrismaClient();
import _ from "lodash";
import { faker } from "@faker-js/faker";

async function generatePart(
  initNumber: number,
  versionedAmount: number,
  courseId: string
) {
  const partResults = [];

  const partIds = [];

  for (let index = 0; index < initNumber; index++) {
    const partId = uuidv4();

    const partVersioned: Prisma.PartVersionedCreateManyPartInput[] = [];
    const coursePartRelation: Prisma.CoursePartRelationCreateManyInput[] = [];

    for (let index = 0; index < versionedAmount; index++) {
      partVersioned.push({
        revision: index + 1,
        title: `${faker.random.alpha(10)}-${index}`,
        metaRevision: index + 1,
      });

      coursePartRelation.push({
        courseId: courseId,
        partId: partId,
        brickRevision: index + 1,
        partMetaRevision: index + 1,
        partRevision: index + 1,
        revision: index + 1,
      });
    }

    const result = await prisma.part.create({
      data: {
        id: partId,
        partVersioneds: {
          createMany: {
            data: partVersioned,
          },
        },
      },
    });

    await prisma.coursePartRelation.createMany({
      data: coursePartRelation,
    });

    partResults.push(result);
    partIds.push(partId);
  }
  return partIds;
}

async function generateSection(
  initNumber: number,
  versionedAmount: number,
  partId: string[]
) {
  const sectionResults = [];
  const sectionIds = [];

  for (let index = 0; index < initNumber; index++) {
    const sectionId = uuidv4();

    const sectionVersioned: Prisma.SectionVersionedCreateManySectionInput[] =
      [];

    const partSectionRelation: Prisma.PartSectionRelationCreateManyInput[] = [];

    for (let index = 0; index < versionedAmount; index++) {
      sectionVersioned.push({
        revision: index + 1,
        title: `${faker.random.alpha(10)}-${index}`,
        metaRevision: index + 1,
      });

      partSectionRelation.push({
        partId: partId[index],
        sectionId: sectionId,
        partMetaRevision: index + 1,
        partRevision: index + 1,
        sectionMetaRevision: index + 1,
        sectionRevision: index + 1,
      });
    }

    const result = await prisma.section.create({
      data: {
        id: sectionId,
        sectionVersioneds: {
          createMany: {
            data: sectionVersioned,
          },
        },
      },
    });

    await prisma.partSectionRelation.createMany({
      data: partSectionRelation,
    });

    sectionIds.push(sectionId);
    sectionResults.push(result);
  }
  return sectionIds;
}

async function generateCourseMasterRecord(
  amount: number,
  versionedAmount: number,
  courseId: string
) {
  const courseMasterRecordResult: Prisma.CourseMasterRecordCreateManyInput[] =
    [];

  const courseMasterRecordRelation: Prisma.CourseMasterRecordRelationCreateManyInput[] =
    [];

  for (let index = 0; index < amount; index++) {
    const id = uuidv4();
    for (let index = 0; index < versionedAmount; index++) {
      courseMasterRecordResult.push({
        masterRecordId: id,
        revision: index + 1,
        masterRecordRevision: 1,
        values: [
          {
            key: "test",
            value: "test",
          },
        ],
      });

      courseMasterRecordRelation.push({
        masterRecordId: id,
        revision: index + 1,
        courseId: courseId,
        masterRecordRevision: 1,
        metaRevision: index + 1,
      });
    }
  }
  const result = await prisma.courseMasterRecord.createMany({
    data: courseMasterRecordResult,
  });

  await prisma.courseMasterRecordRelation.createMany({
    data: courseMasterRecordRelation,
  });

  return result;
}

async function generateSubsection(
  initNumber: number,
  versionedAmount: number,
  sectionIds: string[]
) {
  const subsectionResults = [];
  const subsectionIds = [];

  for (let index = 0; index < initNumber; index++) {
    const subsectionId = uuidv4();

    const subsectionVersioned: Prisma.SubsectionVersionedCreateManySubsectionInput[] =
      [];

    const sectionSubsectionRelation: Prisma.SectionSubsectionRelationCreateManyInput[] =
      [];

    for (let index = 0; index < versionedAmount; index++) {
      subsectionVersioned.push({
        revision: index + 1,
        title: `${faker.random.alpha(10)}-${index}`,
        metaRevision: index + 1,
      });

      sectionSubsectionRelation.push({
        sectionId: sectionIds[index],
        subsectionId: subsectionId,
        sectionMetaRevision: index + 1,
        sectionRevision: index + 1,
        subsectionMetaRevision: index + 1,
        subsectionRevision: index + 1,
      });
    }

    const result = await prisma.subsection.create({
      data: {
        id: subsectionId,
        subsectionVersioneds: {
          createMany: {
            data: subsectionVersioned,
          },
        },
      },
    });

    subsectionIds.push(subsectionId);
    subsectionResults.push(result);
  }
  return subsectionIds;
}

async function generateCourseAsset(
  amount: number,
  versionedAmount: number,
  subsectionIds: string[]
) {
  const courseAssetResults = [];

  for (let index = 0; index < amount; index++) {
    const id = uuidv4();

    const courseAssetVersioned: Prisma.CourseAssetCreateInput[] = [];
    const subsectionCourseAssetRelation: Prisma.SubsectionCourseAssetRelationCreateManyInput[] =
      [];

    for (let index = 0; index < versionedAmount; index++) {
      courseAssetVersioned.push({
        assetId: id,
        assetRevision: 1,
        assetType: "DOCUMENT",
        revision: index + 1,
        displayName: `${faker.random.alpha(10)}-${index}`,
        other: "other",
        timestamp: "timestamp",
      });

      subsectionCourseAssetRelation.push({
        assetId: id,
        assetRevision: 1,
        subsectionId: subsectionIds[index],
        subsectionRevision: index + 1,
        subsectionMetaRevision: index + 1,
      });
    }

    const result = await prisma.courseAsset.createMany({
      data: courseAssetVersioned,
    });

    courseAssetResults.push(result);
  }
  return courseAssetResults;
}

async function generateCourseItem(
  initNumber: number,
  versionedAmount: number,
  courseId: string
) {
  const courseMasterRecord = await generateCourseMasterRecord(
    initNumber,
    versionedAmount,
    courseId
  );
  const partIds = await generatePart(initNumber, versionedAmount, courseId);
  const sectionIds = await generateSection(
    initNumber,
    versionedAmount,
    partIds
  );
  const subsectionIds = await generateSubsection(
    initNumber,
    versionedAmount,
    sectionIds
  );
  const courseAsset = await generateCourseAsset(
    initNumber,
    versionedAmount,
    subsectionIds
  );

  return {
    partIds,
    sectionIds,
    subsectionIds,
    courseMasterRecord,
    courseAsset,
  };
}

async function main() {
  const length = 100;
  const version = 2;
  const courseItemLength = 10;

  await prisma.coursePartRelation.deleteMany();
  await prisma.courseMasterRecordRelation.deleteMany();
  await prisma.sectionSubsectionRelation.deleteMany();
  await prisma.partSectionRelation.deleteMany();
  await prisma.subsectionCourseAssetRelation.deleteMany();
  await prisma.courseBin.deleteMany();
  await prisma.courseAsset.deleteMany();
  await prisma.subsectionVersioned.deleteMany();
  await prisma.subsection.deleteMany();
  await prisma.sectionVersioned.deleteMany();
  await prisma.section.deleteMany();
  await prisma.partVersioned.deleteMany();
  await prisma.part.deleteMany();
  await prisma.courseVersioned.deleteMany();
  await prisma.course.deleteMany();

  for (let index = 0; index < length; index++) {
    const courseId = uuidv4();

    const courseVersioneds: Prisma.CourseVersionedCreateManyCourseInput[] = [];

    for (let index = 0; index < version; index++) {
      courseVersioneds.push({
        brickRevision: index + 1,
        metaRevision: index + 1,
        revision: index + 1,
        internalNote: "test",
      });
    }

    await prisma.course.create({
      data: {
        id: courseId,
        version: "V1",
        courseBin: {
          create: {
            id: uuidv4(),
            assets: [
              {
                test: "test",
              },
            ],
          },
        },
        courseVersioneds: {
          createMany: {
            data: courseVersioneds,
          },
        },
      },
      select: {
        courseVersioneds: true,
      },
    });

    await generateCourseItem(courseItemLength, version, courseId);
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
