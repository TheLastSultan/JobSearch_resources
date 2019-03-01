export const connectionString = process.env.DATABASE_URL || 'postgres://localhost/oauthtutorial';

export const googleConfig = {
  clientID: 'client-id-here',
  clientSecret: 'client-secret-here',
  callbackURL: 'http://localhost:3000/auth/google/callback'
};
