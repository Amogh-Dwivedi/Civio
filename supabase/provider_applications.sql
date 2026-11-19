-- Run in Supabase SQL Editor after your existing setup.sql.
-- Applications are private: applicants may INSERT their own, but cannot read anyone's submissions.
create table if not exists public.provider_applications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  full_name text not null check (char_length(full_name) between 2 and 100),
  phone text not null check (phone ~ '^(\+91)?[6-9][0-9]{9}$'),
  locality text not null check (char_length(locality) between 2 and 120),
  provider_type text not null check (provider_type in ('handicraft','food','tutor','other')),
  description text not null check (char_length(description) between 15 and 1500),
  status text not null default 'pending' check (status in ('pending','reviewing','approved','rejected')),
  created_at timestamptz not null default now()
);
alter table public.provider_applications enable row level security;
revoke all on public.provider_applications from anon, authenticated;
grant insert (user_id, full_name, phone, locality, provider_type, description) on public.provider_applications to authenticated;
drop policy if exists "Applicant can submit own application" on public.provider_applications;
create policy "Applicant can submit own application" on public.provider_applications
  for insert to authenticated with check ((select auth.uid()) = user_id and (select auth.jwt()->>'email') is not null);
-- No SELECT/UPDATE/DELETE policies for website users. Review in Supabase Table Editor as project owner.
notify pgrst, 'reload schema';
