-- =============================================
-- NestIQ Database Schema
-- Run this in Supabase SQL Editor
-- =============================================

-- LEADS TABLE (buyers jo form bharte hain)
CREATE TABLE leads (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT,
  phone TEXT,
  intent TEXT,           -- 'buy' ya 'rent'
  budget TEXT,
  area TEXT,
  bhk TEXT,
  timeline TEXT,
  status TEXT DEFAULT 'new',   -- new, contacted, converted
  created_at TIMESTAMP DEFAULT NOW()
);

-- AGENTS TABLE (agents jo platform pe hain)
CREATE TABLE agents (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  phone TEXT NOT NULL,
  email TEXT,
  area TEXT,
  plan TEXT DEFAULT 'basic',   -- basic, pro, elite
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT NOW()
);

-- LEAD ASSIGNMENTS (kaunsi lead kaunse agent ko gayi)
CREATE TABLE lead_assignments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  lead_id UUID REFERENCES leads(id),
  agent_id UUID REFERENCES agents(id),
  assigned_at TIMESTAMP DEFAULT NOW()
);

-- Allow public inserts for leads (buyers)
ALTER TABLE leads ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Anyone can insert leads" ON leads FOR INSERT WITH CHECK (true);
CREATE POLICY "Anyone can read leads" ON leads FOR SELECT USING (true);

ALTER TABLE agents ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Anyone can read agents" ON agents FOR SELECT USING (true);
CREATE POLICY "Anyone can insert agents" ON agents FOR INSERT WITH CHECK (true);