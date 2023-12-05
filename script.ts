import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const { faker } = require('@faker-js/faker');

const createRandomUser = (): any => {
  return {
    name: faker.person.fullName(),
    email: faker.internet.email(),
    age: faker.number.int({ min: 10, max: 100 }),
    isAdmin: false,
  };
};

async function main() {
  let users = [];
  for (let i = 0; i < 100; i++) {
    const userData = createRandomUser();
    users.push(userData);
  }

  const data = await Promise.all(
    users.map(async (u) => {
      return prisma.user.create({ data: { ...u } });
    })
  );
  console.log(data);
  // const users = await prisma.user.findMany({
  //   where: {
  //     name: {
  //       startsWith: 's',
  //     },
  //   },
  //   select: {
  //     name: true,
  //     email: true,
  //   },
  // });
  // console.log(users);
}

main()
  .catch((error) => {
    console.log(error);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
