module Types where

type LifeWorld = (AliveCells, Control)
type AliveCells = [(Int, Int)]
type Control = (Bool, Int, Int)
