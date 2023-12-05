import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient({ log: ['query'] });

async function main() {
  await prisma.userPreference.deleteMany();
  await prisma.user.deleteMany();
  const user = await prisma.user.create({
    data: {
      name: 'Saliheen Afridi',
      email: 'test@gmail.com',
      age: 25,
      isAdmin: false,
      userPreference: {
        create: {
          emailUpdates: true,
        },
      },
    },
    select: {
      name: true,
      userPreference: {
        select: {
          id: true,
        },
      },
    },
  });

  console.log(user);
}

main()
  .catch((error) => {
    console.log(error);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
