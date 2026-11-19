-- Run once in Supabase SQL Editor. Public listing files live in GitHub, not this database.
create table if not exists public.favourites (
  user_id uuid not null references auth.users(id) on delete cascade,
  service_id text not null check (char_length(service_id) between 1 and 120),
  created_at timestamptz not null default now(),
  primary key (user_id, service_id)
);
alter table public.favourites enable row level security;
revoke all on public.favourites from anon;
grant select, insert, delete on public.favourites to authenticated;
drop policy if exists "Users view their own favourites" on public.favourites;
create policy "Users view their own favourites" on public.favourites for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "Users add their own favourites" on public.favourites;
create policy "Users add their own favourites" on public.favourites for insert to authenticated with check ((select auth.uid()) = user_id);
drop policy if exists "Users remove their own favourites" on public.favourites;
create policy "Users remove their own favourites" on public.favourites for delete to authenticated using ((select auth.uid()) = user_id);
